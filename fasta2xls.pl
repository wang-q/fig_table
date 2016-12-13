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
    [ 'wrap=i',      'wrap length',          { default => 50 }, ],
    [ 'spacing=i',   'wrapped line spacing', { default => 1 }, ],
    [ 'outfile|o=s', 'output filename', ],
    [ 'outgroup',    'alignments have an outgroup', ],
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
# store all variations
#----------------------------------------------------------#

sub get_indels {
    my $seq_refs = shift;

    my $seq_count = scalar @{$seq_refs};

    my $indel_set = AlignDB::IntSpan->new;
    for my $i ( 0 .. $seq_count - 1 ) {
        my $seq_indel_set = App::Fasops::Common::indel_intspan( $seq_refs->[$i] );
        $indel_set->merge($seq_indel_set);
    }

    my @sites;

    # indels
    for my $cur_indel ( $indel_set->spans ) {
        my ( $indel_start, $indel_end ) = @{$cur_indel};
        my $indel_length = $indel_end - $indel_start + 1;

        my @indel_seqs;
        for my $seq ( @{$seq_refs} ) {
            push @indel_seqs, ( substr $seq, $indel_start - 1, $indel_length );
        }
        my $indel_all_seqs = join "|", @indel_seqs;

        my $indel_type;
        my @uniq_indel_seqs = List::MoreUtils::PP::uniq(@indel_seqs);

        # seqs with least '-' char wins
        my ($indel_seq) = map { $_->[0] }
            sort { $a->[1] <=> $b->[1] }
            map { [ $_, tr/-/-/ ] } @uniq_indel_seqs;

        if ( scalar @uniq_indel_seqs < 2 ) {
            Carp::confess "no indel!\n";
            next;
        }
        elsif ( scalar @uniq_indel_seqs > 2 ) {
            $indel_type = 'C';
        }
        elsif ( $indel_seq =~ /-/ ) {
            $indel_type = 'C';
        }
        else {
            #   'D': means deletion relative to target/first seq
            #        target is ----
            #   'I': means insertion relative to target/first seq
            #        target is AAAA
            if ( $indel_seqs[0] eq $indel_seq ) {
                $indel_type = 'I';
            }
            else {
                $indel_type = 'D';
            }
        }

        my $indel_freq = 0;
        my $indel_occured;
        if ( $indel_type eq 'C' ) {
            $indel_freq    = -1;
            $indel_occured = 'unknown';
        }
        else {
            for (@indel_seqs) {

                # same as target 'x', not 'o'
                if ( $indel_seqs[0] eq $_ ) {
                    $indel_freq++;
                    $indel_occured .= '0';
                }
                else {
                    $indel_occured .= '1';
                }
            }
        }

        # here freq is the minor allele freq
        $indel_freq = List::Util::min( $indel_freq, $seq_count - $indel_freq );

        push @sites,
            {
            indel_start    => $indel_start,
            indel_end      => $indel_end,
            indel_length   => $indel_length,
            indel_seq      => $indel_seq,
            indel_all_seqs => $indel_all_seqs,
            indel_freq     => $indel_freq,
            indel_occured  => $indel_occured,
            indel_type     => $indel_type,
            };
    }

    return \@sites;
}

sub polarize_indel {
    my $sites        = shift;
    my $outgroup_seq = shift;

    my $outgroup_indel_set = App::Fasops::Common::indel_intspan($outgroup_seq);

    for my $site ( @{$sites} ) {
        my @indel_seqs = split /\|/, $site->{indel_all_seqs};

        my $outgroup_bases = substr $outgroup_seq, $site->{indel_start} - 1, $site->{indel_length};

        my ( $indel_type, $indel_occured, $indel_freq );

        my $indel_set = AlignDB::IntSpan->new(" $site->{indel_start}- $site->{indel_end}");

        # this line is different to previous subroutines
        my @uniq_indel_seqs = List::MoreUtils::PP::uniq( @indel_seqs, $outgroup_bases );

        # seqs with least '-' char wins
        my ($indel_seq) = map { $_->[0] }
            sort { $a->[1] <=> $b->[1] }
            map { [ $_, tr/-/-/ ] } @uniq_indel_seqs;

        if ( scalar @uniq_indel_seqs < 2 ) {
            Carp::confess "no indel!\n";
        }
        elsif ( scalar @uniq_indel_seqs > 2 ) {
            $indel_type = 'C';
        }
        elsif ( $indel_seq =~ /-/ ) {
            $indel_type = 'C';
        }
        else {

            if (    ( $outgroup_bases !~ /\-/ )
                and ( $indel_seq ne $outgroup_bases ) )
            {

                # this section should already be judged in previes
                # uniq_indel_seqs section, but I keep it here for safe

                # reference indel content does not contain '-' and is not equal
                # to the one of alignment
                #     AAA
                #     A-A
                # ref ACA
                $indel_type = 'C';
            }
            elsif ( $outgroup_indel_set->intersect($indel_set)->is_not_empty ) {
                my $island = $outgroup_indel_set->find_islands($indel_set);
                if ( $island->equal($indel_set) ) {

                    #     NNNN
                    #     N--N
                    # ref N--N
                    $indel_type = 'I';
                }
                else {
                    # reference indel island is larger or smaller
                    #     NNNN
                    #     N-NN
                    # ref N--N
                    # or
                    #     NNNN
                    #     N--N
                    # ref N-NN
                    $indel_type = 'C';
                }
            }
            elsif ( $outgroup_indel_set->intersect($indel_set)->is_empty ) {

                #     NNNN
                #     N--N
                # ref NNNN
                $indel_type = 'D';
            }
            else {
                Carp::confess "Errors when polarizing indel!\n";
            }
        }

        if ( $indel_type eq 'C' ) {
            $indel_occured = 'unknown';
            $indel_freq    = -1;
        }
        else {
            for my $seq (@indel_seqs) {
                if ( $seq eq $outgroup_bases ) {
                    $indel_occured .= '0';
                }
                else {
                    $indel_occured .= '1';
                    $indel_freq++;
                }
            }
        }

        $site->{indel_ref_seq} = $outgroup_bases;
        $site->{indel_type}    = $indel_type;
        $site->{indel_occured} = $indel_occured;
        $site->{indel_freq}    = $indel_freq;
    }

    return;
}

sub get_substitutions {
    my $seq_refs = shift;

    my $align_length = length $seq_refs->[0];
    my $seq_count    = scalar @{$seq_refs};

    # SNPs
    my $snp_bases_of = {};
    for my $pos ( 1 .. $align_length ) {
        my @bases;
        for my $i ( 0 .. $seq_count - 1 ) {
            my $base = substr( $seq_refs->[$i], $pos - 1, 1 );
            push @bases, $base;
        }

        if ( List::MoreUtils::PP::all { $_ =~ /[agct]/i } @bases ) {
            if ( List::MoreUtils::PP::any { $_ ne $bases[0] } @bases ) {
                $snp_bases_of->{$pos} = \@bases;
            }
        }
    }

    my @sites;
    for my $pos ( sort { $a <=> $b } keys %{$snp_bases_of} ) {

        my @bases = @{ $snp_bases_of->{$pos} };

        my $target_base = $bases[0];
        my $all_bases = join '', @bases;

        my $query_base;
        my $mutant_to;
        my $snp_freq = 0;
        my $snp_occured;
        my @class = List::MoreUtils::PP::uniq(@bases);
        if ( scalar @class < 2 ) {
            Carp::confess "no snp\n";
        }
        elsif ( scalar @class > 2 ) {
            $snp_freq    = -1;
            $snp_occured = 'unknown';
        }
        else {
            for (@bases) {
                if ( $target_base ne $_ ) {
                    $snp_freq++;
                    $snp_occured .= '0';
                }
                else {
                    $snp_occured .= '1';
                }
            }
            ($query_base) = grep { $_ ne $target_base } @bases;
            $mutant_to = $target_base . '<->' . $query_base;
        }

        # here freq is the minor allele freq
        $snp_freq = List::Util::min( $snp_freq, $seq_count - $snp_freq );

        push @sites,
            {
            snp_pos     => $pos,
            target_base => $target_base,
            query_base  => $query_base,
            all_bases   => $all_bases,
            mutant_to   => $mutant_to,
            snp_freq    => $snp_freq,
            snp_occured => $snp_occured,
            };
    }

    return \@sites;
}

sub polarize_snp {
    my $sites        = shift;
    my $outgroup_seq = shift;

    for my $site ( @{$sites} ) {
        my $outgroup_base = substr $outgroup_seq, $site->{snp_pos} - 1, 1;

        my @nts = split '', $site->{all_bases};
        my @class;
        for my $nt (@nts) {
            my $class_bool = 0;
            for (@class) {
                if ( $_ eq $nt ) { $class_bool = 1; }
            }
            unless ($class_bool) {
                push @class, $nt;
            }
        }

        my ( $mutant_to, $snp_freq, $snp_occured );

        if ( scalar @class < 2 ) {
            Carp::confess "Not a real SNP\n";
        }
        elsif ( scalar @class == 2 ) {
            for my $nt (@nts) {
                if ( $nt eq $outgroup_base ) {
                    $snp_occured .= '0';
                }
                else {
                    $snp_occured .= '1';
                    $snp_freq++;
                    $mutant_to = "$outgroup_base->$nt";
                }
            }
        }
        else {
            $snp_freq    = -1;
            $mutant_to   = 'Complex';
            $snp_occured = 'unknown';
        }

        # ref_base is not equal to any nts
        if ( $snp_occured eq ( '1' x ( length $snp_occured ) ) ) {
            $snp_freq    = -1;
            $mutant_to   = 'Complex';
            $snp_occured = 'unknown';
        }

        $site->{ref_base}    = $outgroup_base;
        $site->{mutant_to}   = $mutant_to;
        $site->{snp_freq}    = $snp_freq;
        $site->{snp_occured} = $snp_occured;
    }

    return;
}

# including indels and snps
my %variations;

my $seq_of = App::Fasops::Common::read_fasta( $ARGV[0] );

{
    my $seq_refs = [];
    for ( keys %{$seq_of} ) {
        push @{$seq_refs}, uc $seq_of->{$_};
    }

    # check align length
    my $align_length = length $seq_refs->[0];
    for ( @{$seq_refs} ) {
        if ( ( length $_ ) != $align_length ) {
            die "Sequences should have the same length!\n";
        }
    }

    # outgroup
    my $out_seq;
    if ( $opt->{outgroup} ) {
        $out_seq = pop @{$seq_refs};
    }

    my $seq_count = scalar @{$seq_refs};
    if ( $seq_count < 2 ) {
        Carp::confess "Too few sequences [$seq_count]\n";
    }

    my $indel_sites = get_indels($seq_refs);
    if ( $opt->{outgroup} ) {
        polarize_indel( $indel_sites, $out_seq );
    }

    for my $site ( @{$indel_sites} ) {
        $site->{var_type} = 'indel';
        $variations{ $site->{indel_start} } = $site;
    }

    my $snp_sites = get_substitutions($seq_refs);
    if ( $opt->{outgroup} ) {
        polarize_snp( $snp_sites, $out_seq );
    }

    for my $site ( @{$snp_sites} ) {
        $site->{var_type} = 'snp';
        $variations{ $site->{snp_pos} } = $site;
    }
}

#----------------------------------------------------------#
# Excel format
#----------------------------------------------------------#
# Create workbook and worksheet objects
my $workbook = Excel::Writer::XLSX->new( $opt->{outfile} );

#@type Excel::Writer::XLSX::Worksheet
my $sheet = $workbook->add_worksheet;

# species name
my $name_format = $workbook->add_format(
    font => 'Courier New',
    size => 10,
);

# variation position
my $pos_format = $workbook->add_format(
    font     => 'Courier New',
    size     => 8,
    align    => 'center',
    valign   => 'vcenter',
    rotation => 90,
);

my $snp_format   = {};
my $indel_format = {};

{    # background
    my $bg_of = {};

    # 14
    my @colors = (
        26,    # Ivory
        27,    # Lite Turquoise
        43,    # Light Yellow
        42,    # Light Green
        51,    # Gold
        50,    # Lime
        22,    # Gray-25%, silver
        24,    # Periwinkle
        31,    # Ice Blue
        30,    # Ocean Blue
        46,    # lightpurple
        48,    # Light Blue
        55,    # Blue-Gray
        62,    # Indigo
    );

    for my $i ( 0 .. $#colors ) {
        $bg_of->{$i}{bg_color} = $colors[$i];

    }
    $bg_of->{unknown}{bg_color} = 9;    # white

    # snp base
    my $snp_fg_of = {
        A   => { color => 'green', },
        C   => { color => 'blue', },
        G   => { color => 'pink', },
        T   => { color => 'red', },
        N   => { color => 'black' },
        '-' => { color => 'black' },
    };

    for my $fg ( keys %{$snp_fg_of} ) {
        for my $bg ( keys %{$bg_of} ) {
            $snp_format->{"$fg$bg"} = $workbook->add_format(
                font   => 'Courier New',
                size   => 10,
                align  => 'center',
                valign => 'vcenter',
                %{ $snp_fg_of->{$fg} },
                %{ $bg_of->{$bg} },
            );
        }
    }
    $snp_format->{'-'} = $workbook->add_format(
        font   => 'Courier New',
        size   => 10,
        align  => 'center',
        valign => 'vcenter',
    );

    for my $bg ( keys %{$bg_of} ) {
        $indel_format->{$bg} = $workbook->add_format(
            font   => 'Courier New',
            size   => 10,
            bold   => 1,
            align  => 'center',
            valign => 'vcenter',
            %{ $bg_of->{$bg} },
        );
    }
}

#----------------------------------------------------------#
# write execel
#----------------------------------------------------------#
print "Write excel...\n";

my $seq_count = scalar keys %{$seq_of};
if ( $opt->{outgroup} ) {
    $seq_count--;
}

my $col_cursor     = 1;
my $section        = 1;
my $section_height = ( scalar( keys %{$seq_of} ) + 1 ) + $opt->{spacing};

for my $pos ( sort { $a <=> $b } keys %variations ) {
    my $var = $variations{$pos};
    my $pos_row = $section_height * ( $section - 1 );

    # write SNPs
    if ( $var->{var_type} eq 'snp' ) {

        # write position
        $sheet->write( $pos_row, $col_cursor, $var->{snp_pos}, $pos_format );

        for my $i ( 1 .. $seq_count ) {
            my $base = substr $var->{all_bases},   $i - 1, 1;
            my $occ  = substr $var->{snp_occured}, $i - 1, 1;

            if ( $occ eq "1" ) {

                my $bg_idx
                    = $var->{snp_occured} eq "unknown"
                    ? "unknown"
                    : oct( '0b' . $var->{snp_occured} ) % 14;
                my $base_color = $base . $bg_idx;
                $sheet->write( $pos_row + $i, $col_cursor, $base, $snp_format->{$base_color} );
            }
            else {
                my $base_color = $base . "unknown";
                $sheet->write( $pos_row + $i, $col_cursor, $base, $snp_format->{$base_color} );
            }
        }

        if ( $opt->{outgroup} ) {
            my $base_color = $var->{ref_base} . "unknown";
            $sheet->write( $pos_row + $seq_count + 1,
                $col_cursor, $var->{ref_base}, $snp_format->{$base_color} );
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
            $section++;
            $pos_row = $section_height * ( $section - 1 );
        }

        my $indel_string = "$var->{indel_type}$var->{indel_length}";

        my $bg_idx = 'unknown';
        if ( $var->{indel_occured} ne 'unknown' ) {
            $bg_idx = oct( '0b' . $var->{indel_occured} ) % 14;
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
                    $sheet->write( $pos_row, $col_cursor, $var->{indel_start}, $pos_format );

                    # write in indel occured lineage
                    $sheet->write( $pos_row + $i,
                        $col_cursor, $indel_string, $indel_format->{$bg_idx} );
                }
                elsif ( $col_taken == 2 ) {

                    # write indel_start position
                    $sheet->write( $pos_row, $col_cursor, $var->{indel_start}, $pos_format );

                    # write indel_end position
                    $sheet->write( $pos_row, $col_cursor + 1, $var->{indel_end}, $pos_format );

                    # merge two indel position
                    $sheet->merge_range(
                        $pos_row + $i,
                        $col_cursor,
                        $pos_row + $i,
                        $col_cursor + 1,
                        $indel_string, $indel_format->{$bg_idx},
                    );
                }
                else {

                    # write indel_start position
                    $sheet->write( $pos_row, $col_cursor, $var->{indel_start}, $pos_format );

                    # write middle sign
                    $sheet->write( $pos_row, $col_cursor + 1, '|', $pos_format );

                    # write indel_end position
                    $sheet->write( $pos_row, $col_cursor + 2, $var->{indel_end}, $pos_format );

                    # merge two indel position
                    $sheet->merge_range(
                        $pos_row + $i,
                        $col_cursor,
                        $pos_row + $i,
                        $col_cursor + 2,
                        $indel_string, $indel_format->{$bg_idx},
                    );
                }
            }
        }

        # increase column cursor
        $col_cursor += $col_taken;
    }

    if ( $col_cursor > $opt->{wrap} ) {
        $col_cursor = 1;
        $section++;
    }
}

# write names
my @seq_names = keys %{$seq_of};
for my $i ( 1 .. $section ) {
    my $pos_row = $section_height * ( $i - 1 );

    for my $j ( 1 .. scalar @seq_names ) {
        $sheet->write( $pos_row + $j, 0, $seq_names[ $j - 1 ], $name_format );

    }
}

# format column
my $max_name_length = List::Util::max( map {length} @seq_names );
$sheet->set_column( 0, 0, $max_name_length + 2 );
$sheet->set_column( 1, $opt->{wrap} + 3, 1.6 );

$workbook->close;

exit;

__END__
