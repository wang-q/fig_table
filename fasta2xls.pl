#!/usr/bin/env perl
use strict;
use warnings;
use autodie;

use Getopt::Long::Descriptive;
use YAML::Syck;

use Excel::Writer::XLSX;
use List::Util;
use List::MoreUtils::PP;
use Path::Tiny;

use AlignDB::IntSpan;
use App::Fasops::Common;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

my $description = <<'EOF';
Generate a colorful excel file for one alignment

    perl fasta2xlsx.pl example.fas

Usage: perl %c <in.fasta> [options]
EOF

(
    #@type Getopt::Long::Descriptive::Opts
    my $opt,

    #@type Getopt::Long::Descriptive::Usage
    my $usage,
    )
    = Getopt::Long::Descriptive::describe_options(
    $description,
    [ 'help|h', 'display this message' ],
    [],
    [ 'outfile|o=s', 'output filename', ],
    [ "length|l=i", "the threshold of alignment length", { default => 1 } ],
    [ 'wrap=i',     'wrap length',                       { default => 50 }, ],
    [ 'spacing=i',  'wrapped line spacing',              { default => 1 }, ],
    [ 'outgroup',   'alignments have an outgroup', ],
    { show_defaults => 1, }
    );

$usage->die if $opt->{help};

if ( @ARGV != 1 ) {
    my $message = "This script need one input fasta files.\n\tIt found";
    $message .= sprintf " [%s]", $_ for @ARGV;
    $message .= ".\n";
    $usage->die( { pre_text => $message } );
}
for (@ARGV) {
    if ( !Path::Tiny::path($_)->is_file ) {
        $usage->die( { pre_text => "The input file [$_] doesn't exist.\n" } );
    }
}

if ( !exists $opt->{outfile} ) {
    $opt->{outfile} = Path::Tiny::path( $ARGV[0] )->absolute . ".xlsx";
}

#----------------------------------------------------------#
# Excel format
#----------------------------------------------------------#
sub create_formats {

    #@type Excel::Writer::XLSX
    my $workbook = shift;

    my $format_of = {};

    # species name
    $format_of->{name} = $workbook->add_format(
        font => 'Courier New',
        size => 10,
    );

    # variation position
    $format_of->{pos} = $workbook->add_format(
        font     => 'Courier New',
        size     => 8,
        align    => 'center',
        valign   => 'vcenter',
        rotation => 90,
    );

    $format_of->{snp}   = {};
    $format_of->{indel} = {};

    # background
    my $bg_of = {};

    # 16
    my @colors = (
        22,    # Gray-25%, silver
        43,    # Light Yellow       0b001
        42,    # Light Green        0b010
        27,    # Lite Turquoise
        44,    # Pale Blue          0b100
        46,    # Lavender
        47,    # Tan
        24,    # Periwinkle
        49,    # Aqua
        51,    # Gold
        45,    # Rose
        52,    # Light Orange
        26,    # Ivory
        29,    # Coral
        31,    # Ice Blue

        #        50,    # Lime
        #        48,    # Light Blue
        #        41,    # Light Turquoise, again
        #        30,    # Ocean Blue
        #        54,    # Blue-Gray
        #        62,    # Indigo
    );
    my $loop = scalar @colors;

    for my $i ( 0 .. $#colors ) {
        $bg_of->{$i}{bg_color} = $colors[$i];

    }
    $bg_of->{unknown}{bg_color} = 9;    # White

    # snp base
    my $snp_fg_of = {
        A   => { color => 58, },        # Dark Green
        C   => { color => 18, },        # Dark Blue
        G   => { color => 28, },        # Dark Purple
        T   => { color => 16, },        # Dark Red
        N   => { color => 8 },          # Black
        '-' => { color => 8 },          # Black
    };

    for my $fg ( keys %{$snp_fg_of} ) {
        for my $bg ( keys %{$bg_of} ) {
            $format_of->{snp}{"$fg$bg"} = $workbook->add_format(
                font   => 'Courier New',
                size   => 10,
                align  => 'center',
                valign => 'vcenter',
                %{ $snp_fg_of->{$fg} },
                %{ $bg_of->{$bg} },
            );
        }
    }
    $format_of->{snp}{'-'} = $workbook->add_format(
        font   => 'Courier New',
        size   => 10,
        align  => 'center',
        valign => 'vcenter',
    );

    for my $bg ( keys %{$bg_of} ) {
        $format_of->{indel}->{$bg} = $workbook->add_format(
            font   => 'Courier New',
            size   => 10,
            bold   => 1,
            align  => 'center',
            valign => 'vcenter',
            %{ $bg_of->{$bg} },
        );
    }

    return ( $format_of, $loop );
}

# Create workbook and worksheet objects
#@type Excel::Writer::XLSX
my $workbook = Excel::Writer::XLSX->new( $opt->{outfile} );

#@type Excel::Writer::XLSX::Worksheet
my $worksheet = $workbook->add_worksheet;

my ( $format_of, $color_loop ) = create_formats($workbook);

#----------------------------------------------------------#
# Read every blocks
#----------------------------------------------------------#

#@type IO::Zlib
my $in_fh = IO::Zlib->new( $ARGV[0], "rb" );

my $section = 1;
my $content = '';    # content of one block
while (1) {
    last if $in_fh->eof and $content eq '';

    my $line = '';
    if ( !$in_fh->eof ) {
        $line = $in_fh->getline;
    }
    if ( ( $line eq '' or $line =~ /^\s+$/ ) and $content ne '' ) {
        my $info_of = App::Fasops::Common::parse_block( $content, 1 );
        $content = '';

        my @full_names;
        my $seq_refs = [];

        for my $key ( keys %{$info_of} ) {
            push @full_names, $key;
            push @{$seq_refs}, $info_of->{$key}{seq};
        }

        # check align length
        my $align_length = length $seq_refs->[0];
        for ( @{$seq_refs} ) {
            if ( ( length $_ ) != $align_length ) {
                die "Sequences should have the same length!\n";
            }
        }

        if ( $opt->{length} ) {
            next if $align_length < $opt->{length};
        }

        print "Section [$section]\n";

        # including indels and snps
        my $vars = get_variations( $seq_refs, $opt->{outgroup} );
        $section = paint_variations( $worksheet, $vars, \@full_names, $section );
    }
    else {
        $content .= $line;
    }
}

$in_fh->close;

$workbook->close;

exit;

#----------------------------------------------------------#
# Subroutines
#----------------------------------------------------------#

# store all variations
sub get_variations {
    my $seq_refs     = shift;
    my $has_outgroup = shift;

    # outgroup
    my $out_seq;
    if ($has_outgroup) {
        $out_seq = pop @{$seq_refs};
    }

    my $seq_count = scalar @{$seq_refs};
    if ( $seq_count < 2 ) {
        Carp::confess "Too few sequences [$seq_count]\n";
    }

    my $indel_sites = App::Fasops::Common::get_indels($seq_refs);
    if ( $opt->{outgroup} ) {
        App::Fasops::Common::polarize_indel( $indel_sites, $out_seq );
    }

    my $snp_sites = App::Fasops::Common::get_snps($seq_refs);
    if ( $opt->{outgroup} ) {
        App::Fasops::Common::polarize_snp( $snp_sites, $out_seq );
    }

    my %variations;
    for my $site ( @{$indel_sites} ) {
        $site->{var_type} = 'indel';
        $variations{ $site->{indel_start} } = $site;
    }

    for my $site ( @{$snp_sites} ) {
        $site->{var_type} = 'snp';
        $variations{ $site->{snp_pos} } = $site;
    }

    return \%variations;
}

# write execel
sub paint_variations {

    #@type Excel::Writer::XLSX::Worksheet
    my $sheet         = shift;
    my $vars          = shift;
    my $name_refs     = shift;
    my $section_start = shift;

    my %variations     = %{$vars};
    my $section_cur    = $section_start;
    my $col_cursor     = 1;
    my $section_height = ( scalar( keys @{$name_refs} ) + 1 ) + $opt->{spacing};
    my $seq_count      = scalar @{$name_refs};
    $seq_count-- if $opt->{outgroup};

    for my $pos ( sort { $a <=> $b } keys %variations ) {
        my $var = $variations{$pos};
        my $pos_row = $section_height * ( $section_cur - 1 );

        # write SNPs
        if ( $var->{var_type} eq 'snp' ) {

            # write position
            $sheet->write( $pos_row, $col_cursor, $var->{snp_pos}, $format_of->{pos} );

            for my $i ( 1 .. $seq_count ) {
                my $base = substr $var->{all_bases},   $i - 1, 1;
                my $occ  = substr $var->{snp_occured}, $i - 1, 1;

                if ( $occ eq "1" ) {
                    my $bg_idx
                        = $var->{snp_occured} eq "unknown"
                        ? "unknown"
                        : oct( '0b' . $var->{snp_occured} ) % $color_loop;
                    my $base_color = $base . $bg_idx;
                    $sheet->write( $pos_row + $i,
                        $col_cursor, $base, $format_of->{snp}{$base_color} );
                }
                else {
                    my $base_color = $base . "unknown";
                    $sheet->write( $pos_row + $i,
                        $col_cursor, $base, $format_of->{snp}{$base_color} );
                }
            }

            if ( $opt->{outgroup} ) {
                my $base_color = $var->{outgroup_base} . "unknown";
                $sheet->write( $pos_row + $seq_count + 1,
                    $col_cursor, $var->{outgroup_base}, $format_of->{snp}{$base_color} );
            }

            # increase column cursor
            $col_cursor++;
        }

        # write indels
        if ( $var->{var_type} eq 'indel' ) {

            # how many column does this indel take up
            my $col_taken = List::Util::min( $var->{indel_length}, 3 );

            # if exceed the wrap limit, start a new section
            if ( $col_cursor + $col_taken > $opt->{wrap} ) {
                $col_cursor = 1;
                $section_cur++;
                $pos_row = $section_height * ( $section_cur - 1 );
            }

            my $indel_string = "$var->{indel_type}$var->{indel_length}";

            my $bg_idx = 'unknown';
            if ( $var->{indel_occured} ne 'unknown' ) {
                $bg_idx = oct( '0b' . $var->{indel_occured} ) % $color_loop;
            }

            for my $i ( 1 .. $seq_count ) {
                my $flag = 0;
                if ( $var->{indel_occured} eq "unknown" ) {
                    $flag = 1;
                }
                else {
                    my $occ = substr $var->{indel_occured}, $i - 1, 1;
                    if ( $occ eq '1' ) {
                        $flag = 1;
                    }
                }

                if ($flag) {
                    if ( $col_taken == 1 ) {

                        # write position
                        $sheet->write( $pos_row, $col_cursor, $var->{indel_start},
                            $format_of->{pos} );

                        # write in indel occured lineage
                        $sheet->write( $pos_row + $i,
                            $col_cursor, $indel_string, $format_of->{indel}{$bg_idx} );
                    }
                    elsif ( $col_taken == 2 ) {

                        # write indel_start position
                        $sheet->write( $pos_row, $col_cursor, $var->{indel_start},
                            $format_of->{pos} );

                        # write indel_end position
                        $sheet->write( $pos_row, $col_cursor + 1,
                            $var->{indel_end}, $format_of->{pos} );

                        # merge two indel position
                        $sheet->merge_range(
                            $pos_row + $i,
                            $col_cursor,
                            $pos_row + $i,
                            $col_cursor + 1,
                            $indel_string, $format_of->{indel}{$bg_idx},
                        );
                    }
                    else {

                        # write indel_start position
                        $sheet->write( $pos_row, $col_cursor, $var->{indel_start},
                            $format_of->{pos} );

                        # write middle sign
                        $sheet->write( $pos_row, $col_cursor + 1, '|', $format_of->{pos} );

                        # write indel_end position
                        $sheet->write( $pos_row, $col_cursor + 2,
                            $var->{indel_end}, $format_of->{pos} );

                        # merge two indel position
                        $sheet->merge_range(
                            $pos_row + $i,
                            $col_cursor,
                            $pos_row + $i,
                            $col_cursor + 2,
                            $indel_string, $format_of->{indel}{$bg_idx},
                        );
                    }
                }
            }

            # increase column cursor
            $col_cursor += $col_taken;
        }

        if ( $col_cursor > $opt->{wrap} ) {
            $col_cursor = 1;
            $section_cur++;
        }
    }

    # write names
    for my $i ( $section_start .. $section_cur ) {
        my $pos_row = $section_height * ( $i - 1 );

        for my $j ( 1 .. scalar @{$name_refs} ) {
            $sheet->write( $pos_row + $j, 0, $name_refs->[ $j - 1 ], $format_of->{name} );
        }
    }

    # format column
    my $max_name_length = List::Util::max( map {length} @{$name_refs} );
    $sheet->set_column( 0, 0, $max_name_length + 1 );
    $sheet->set_column( 1, $opt->{wrap} + 3, 1.6 );

    $section_cur++;
    return $section_cur;
}

__END__
