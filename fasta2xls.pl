#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;
use Config::Tiny;
use YAML qw(Dump Load DumpFile LoadFile);

use File::Find::Rule;
use Spreadsheet::WriteExcel;
use Spreadsheet::WriteExcel::Big;

use AlignDB::IntSpan;
use AlignDB::Util qw(:all);

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

my $fastadir  = '';
my $outfile   = '';
my $align_cnt = 4;
my $ref_exist = 1;
my $step      = 0;
my $spices;

my $man  = 0;
my $help = 0;

GetOptions(
    'help|?'      => \$help,
    'man'         => \$man,
    'fastadir=s'  => \$fastadir,
    'spices=s'    => \$spices,
    'align_cnt=i' => \$align_cnt,
    'ref_exist=i' => \$ref_exist,
    'step=i'      => \$step,
    'outfile=s'   => \$outfile
) or pod2usage(2);

pod2usage(1) if $help;
pod2usage( -exitstatus => 0, -verbose => 2 ) if $man;

#if($align_cnt > 6){
#    die "not enough colors\noption --align should less than 7\n";
#}

unless ($outfile) {
    $outfile = $fastadir;
    $outfile =~ s/\.fa.+/\.xls/;
}

#----------------------------------------------------------#
# Search for all FASTA files
#----------------------------------------------------------#
my @fasta_files = File::Find::Rule->file->name( '*.fa', '*.fas', '*.fasta' )
    ->in($fastadir);

my $using_color_cnt = ( 2**$align_cnt ) / 2 - 1;
my $row             = 0;
my $col             = 1;
my $workbook        = Spreadsheet::WriteExcel::Big->new($outfile);
my $worksheet       = $workbook->add_worksheet($outfile);
$worksheet->set_column( 1, 61, 1.2 );

# snp base format
my $snp_fg_of = {
    A   => { color => 'green', },
    C   => { color => 'blue', },
    G   => { color => 'pink', },
    T   => { color => 'red', },
    N   => { color => 'black' },
    '-' => { color => 'black' },
};

my @colors = qw{
    26 27
    43 42
    51 50
    22 24
    31 30
    46 48
    54 62
};

my @patterns = (
    1,     # solid
           #11, # thin, hor
           #12, # thin, ver
    18,    # 6.25% grep
);

my $bg_of     = {};
my $bg_number = 1;
while ( my @pair_colors = splice @colors, 0, 2 ) {
    for my $i (@patterns) {
        for my $j (@pair_colors) {
            $bg_of->{$bg_number}->{pattern}  = $i;
            $bg_of->{$bg_number}->{bg_color} = $j;
            $bg_number++;
        }
    }
}
$bg_of->{unknown}->{bg_color} = 9;

#DumpFile( "var.yaml", $bg_of );

my $snp_format = {};
for my $fg ( keys %{$snp_fg_of} ) {
    for my $bg ( keys %{$bg_of} ) {
        $snp_format->{"$fg$bg"} = $workbook->add_format(
            font  => 'Courier New',
            size  => 8,
            bold  => 1,
            align => 'center',
            %{ $snp_fg_of->{$fg} },
            %{ $bg_of->{$bg} },
        );
    }
}
$snp_format->{'-'} = $workbook->add_format(
    font  => 'Courier New',
    size  => 8,
    bold  => 1,
    align => 'center',
);

my $indel_format = {};
for my $bg ( keys %{$bg_of} ) {
    $indel_format->{$bg} = $workbook->add_format(
        font  => 'Courier New',
        size  => 8,
        bold  => 1,
        align => 'center',
        %{ $bg_of->{$bg} },
    );
}

# variation position format
my $pos_format = $workbook->add_format(
    font     => 'Courier New',
    size     => 8,
    align    => 'center',
    valign   => 'vcenter',
    rotation => 90,
);

foreach my $fasta_file (@fasta_files) {

    my ( $seq_of, $seq_names ) = read_fasta($fasta_file);
    my @seq_names = @{$seq_names};
    my @seqs;
    for (@seq_names) {
        push @seqs, $seq_of->{$_};
    }

    my @indels;
    my @snps;

    my $align_length = length $seqs[0];

    # find indel
    my $indel_set = AlignDB::IntSpan->new;
    my $ref = shift @seqs;
    for (@seqs) {
        my $cur_indel_set = find_indel_set($_);
        $indel_set->merge($cur_indel_set);
    }
    unshift @seqs, $ref;

    my $align_set      = AlignDB::IntSpan->new("1-$align_length");
    my $comparable_set = $align_set->diff($indel_set);

    #indels
    if ( $indel_set->is_not_empty ) {
        for my $cur_indel ( $indel_set->spans ) {
            my ( $indel_start, $indel_end ) = @{$cur_indel};
            my $indel_length = $indel_end - $indel_start + 1;
            my @indel_seqs;
            for my $curr_seq (@seqs) {
                push @indel_seqs,
                    ( substr $curr_seq, $indel_start - 1, $indel_length );
            }


            my $indel_seq = '';
            my $indel_type;
            my @indel_class;
            foreach my $seq (@indel_seqs) {
                unless ( $seq =~ /-/ || $seq =~ /N/ ) {
                    if ( $indel_seq =~ /-/ ) { die "aaaa$seq\n"; }
                    $indel_seq = $seq;
                }
                my $class_bull = 0;
                foreach (@indel_class) {
                    if ( $_ eq $seq ) { $class_bull = 1; }
                }
                unless ($class_bull) {
                    push @indel_class, $seq;
                }
            }

            if ( scalar @indel_class < 2 ) {
                die "no indel!\n";
            }
            elsif ( scalar @indel_class > 2 ) {
                $indel_type = 'C';
            }
            my $ref_seq = shift @indel_seqs;
            unless ($indel_type) {
                if ( $ref_seq eq ( '-' x ( length $ref_seq ) ) ) {
                    $indel_type = 'I';
                }
                elsif ( !( $ref_seq =~ /-/ ) ) {
                    $indel_type = 'D';
                }
                else {
                    die $cur_indel;
                }
            }
            my $indel_frequency = 0;
            my $indel_occured;
            if ( $indel_type eq 'C' ) {
                $indel_frequency = -1;
                $indel_occured   = 'unknown';
            }
            else {
                foreach (@indel_seqs) {
                    if ( $ref_seq ne $_ ) {
                        $indel_frequency++;
                        $indel_occured .= '0';
                    }
                    else {
                        $indel_occured .= '1';
                    }
                }
            }

            my $indel_color = 'unknown';
            unless ( $indel_occured eq 'unknown' ) {
                $indel_color = '0b' . $indel_occured;
                $indel_color = oct $indel_color;
                if ( $indel_color > $using_color_cnt ) {
                    $indel_color = $using_color_cnt * 2 - $indel_color + 1;
                }
                if ( $indel_color > $using_color_cnt ) {
                    die "indel_color = $indel_color\n";
                }
            }
            
            if ($ref_exist) {
                if ( $indel_occured eq
                    ( '1' . ( '0' x ( ( length $indel_occured ) - 1 ) ) ) )
                {
                    next;
                }
                if ( $indel_occured eq
                    ( '0' . ( '1' x ( ( length $indel_occured ) - 1 ) ) ) )
                {
                    next;
                }
            }
            my $ref;
            $ref->{'position'} = $indel_start;
            $ref->{'length'}   = $indel_end - $indel_start + 1;
            $ref->{'occured'}  = $indel_occured;
            $ref->{'color'}    = $indel_color;
            $ref->{'seq'}      = $indel_seq;
            $ref->{'type'}     = $indel_type;
            push @indels, $ref;
        }
    }
    print "indels found\n";

    #snps
    $comparable_set = $comparable_set->diff($indel_set);
    my $snp_positon = 1;
    while ( $snp_positon <= $align_length ) {
        if ( $snp_positon % 1000 == 0 ) {
            print "$snp_positon:$align_length\n";
        }
        if ( $step && $step + $snp_positon <= $align_length ) {
            my $bull = 1;
            my $ref_seq = substr $seqs[0], $snp_positon - 1, $step;
            foreach my $current_seq (@seqs) {
                my $test_seq = substr $current_seq, $snp_positon - 1, $step;
                if ( $test_seq ne $ref_seq ) {
                    $bull = 0;
                    last;
                }
            }
            if ($bull) {
                $snp_positon += $step;
                next;
            }
        }

        #print $snp_positon,"\n";
        unless ( $comparable_set->member($snp_positon) ) {
            $snp_positon++;
            next;
        }
        my @nucleotides;
        my $class = 1;
        foreach my $current_seq (@seqs) {
            my $current_nuc = substr $current_seq, $snp_positon - 1, 1;
            foreach my $test_nuc (@nucleotides) {
                if ( $test_nuc ne $current_nuc ) { $class++; }
            }
            push @nucleotides, $current_nuc;
        }
        if ( $class > 1 ) {
            my $snp_base = join '', @nucleotides;
            my @snp_class;
            my $snp_occured = '';
            my $complex     = 0;
            foreach my $nuc (@nucleotides) {
                my $class_bull = 0;
                foreach (@snp_class) {
                    if ( $_ eq $nuc ) { $class_bull = 1; }
                    unless (/[ATCG]/i) { $complex = 1; }
                }
                unless ($class_bull) {
                    push @snp_class, $nuc;
                }
            }

            if ( scalar @snp_class < 2 ) {
                die "no snp!\n";
            }
            elsif ( scalar @snp_class > 2 || $complex ) {
                $snp_occured = 'unknown';
            }
            else {
                my $ref_base = $nucleotides[0];
                foreach (@nucleotides) {
                    if ( $_ eq $ref_base ) {
                        $snp_occured .= '0';
                    }
                    else {
                        $snp_occured .= '1';
                    }
                }
            }

            my $snp_color = 'unknown';
            unless ( $snp_occured eq 'unknown' ) {
                $snp_color = '0b' . $snp_occured;
                $snp_color = oct $snp_color;
                if ( $snp_color > $using_color_cnt ) {
                    $snp_color = $using_color_cnt * 2 - $snp_color + 1;
                }
                if ( $snp_color > $using_color_cnt ) {
                    die "snp_color = $snp_color\n";
                }
            }

            if ($ref_exist) {
                if ( $snp_occured eq
                    ( '1' . ( '0' x ( ( length $snp_occured ) - 1 ) ) ) )
                {
                    $snp_positon++;
                    next;
                }
                if ( $snp_occured eq
                    ( '0' . ( '1' x ( ( length $snp_occured ) - 1 ) ) ) )
                {
                    $snp_positon++;
                    next;
                }
            }

            my $ref;
            $ref->{'position'} = $snp_positon;
            $ref->{'base'}     = $snp_base;
            $ref->{'occured'}  = $snp_occured;
            $ref->{'color'}    = $snp_color;
            push @snps, $ref;
        }
        $snp_positon++;
    }
    print "snps found\nwriting excel\n";

    my ( $i, $j ) = ( 0, 0 );

    #my ($line1,$line2,$line3,$line4,$line5);
    my $line_control = 60;
    my $write_cycal  = 0;
    while ( $write_cycal < $align_cnt ) {
        $worksheet->write( $row + $write_cycal + 1,
            0, $seq_names[$write_cycal] );
        $write_cycal++;
    }
    while ( ( $i < ( scalar @indels ) ) || ( $j < ( scalar @snps ) ) ) {
        if ( ( $i > ( scalar @indels ) ) || ( $j > ( scalar @snps ) ) ) {
            die;
        }
        if ( $i == ( scalar @indels ) ) {
            if ( $col > 60 ) {
                $col = 1;
                $row += ( $align_cnt + 1 );
                $write_cycal = 0;
                while ( $write_cycal < $align_cnt ) {
                    $worksheet->write( $row + $write_cycal + 1,
                        0, $seq_names[$write_cycal] );
                    $write_cycal++;
                }
            }
            my @smp_bases = split //, $snps[$j]->{'base'};
            $worksheet->write( $row, $col, ( $snps[$j]->{'position'} ),
                $pos_format );
            $write_cycal = 0;
            while ( $write_cycal < $align_cnt ) {
                $worksheet->write(
                    $row + $write_cycal + 1,
                    $col,
                    $smp_bases[$write_cycal],
                    $snp_format->{ $smp_bases[$write_cycal]
                            . $snps[$j]->{'color'} }
                );
                $write_cycal++;
            }
            $col++;
            $j++;
            next;
        }
        if ( $j == ( scalar @snps ) ) {
            if ( $col > 58 ) {
                $col = 1;
                $row += ( $align_cnt + 1 );
                $write_cycal = 0;
                while ( $write_cycal < $align_cnt ) {
                    $worksheet->write( $row + $write_cycal + 1,
                        0, $seq_names[$write_cycal] );
                    $write_cycal++;
                }
            }
            if ( $indels[$i]->{'type'} eq 'I' ) {
                $worksheet->write( $row, $col, ( $indels[$i]->{'position'} ),
                    $pos_format );
                $worksheet->write( $row, $col + 1, '-',
                    ( $snp_format->{'-'} ) );
                $worksheet->write(
                    $row,
                    $col + 2,
                    (         $indels[$i]->{'position'} 
                            + $indels[$i]->{'length'} - 1
                    ),
                    $pos_format
                );
                my @occur_temps = split //, $indels[$i]->{'occured'};
                unless ( scalar @occur_temps == $align_cnt ) {
                    die "indel occur error\n";
                }
                my $k = 0;
                while ( $k < $align_cnt ) {
                    if ( $occur_temps[$k] eq '0' ) {
                        my $temp = 'D' . $indels[$i]->{'length'};
                        $worksheet->write( $row + $k + 1,
                            $col + 1, $temp,
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col + 2, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                    }
                    elsif ( $occur_temps[$k] eq '1' ) {
                        my $temp = 'D' . $indels[$i]->{'length'};
                        $worksheet->write( $row + $k + 1,
                            $col + 1, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col + 2, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                    }
                    else {
                        die "indel type error 218\n";
                    }
                    $k++;
                }
            }
            elsif ( $indels[$i]->{'type'} eq 'D' ) {
                $worksheet->write( $row, $col, ( $indels[$i]->{'position'} ),
                    $pos_format );
                $worksheet->write( $row, $col + 1, '-',
                    ( $snp_format->{'-'} ) );
                $worksheet->write(
                    $row,
                    $col + 2,
                    (         $indels[$i]->{'position'} 
                            + $indels[$i]->{'length'} - 1
                    ),
                    $pos_format
                );
                my @occur_temps = split //, $indels[$i]->{'occured'};
                unless ( scalar @occur_temps == $align_cnt ) {
                    die "indel occur error\n";
                }
                my $k = 0;
                while ( $k < $align_cnt ) {
                    if ( $occur_temps[$k] eq '0' ) {
                        my $temp = 'D' . $indels[$i]->{'length'};
                        $worksheet->write( $row + $k + 1,
                            $col + 1, $temp,
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col + 2, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                    }
                    elsif ( $occur_temps[$k] eq '1' ) {
                        my $temp = 'D' . $indels[$i]->{'length'};
                        $worksheet->write( $row + $k + 1,
                            $col + 1, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col + 2, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                    }
                    else {
                        die "indel type error 241\n";
                    }
                    $k++;
                }
            }
            elsif ( $indels[$i]->{'type'} eq 'C' ) {
                $worksheet->write( $row, $col, ( $indels[$i]->{'position'} ),
                    $pos_format );
                $worksheet->write( $row, $col + 1, '-',
                    ( $snp_format->{'-'} ) );
                $worksheet->write(
                    $row,
                    $col + 2,
                    (         $indels[$i]->{'position'} 
                            + $indels[$i]->{'length'} - 1
                    ),
                    $pos_format
                );
                my $temp = 'C' . $indels[$i]->{'length'};
                $worksheet->write( $row + 1, $col + 1, $temp,
                    $indel_format->{ $indels[$i]->{'color'} } );
                $worksheet->write( $row + 1, $col, '',
                    $indel_format->{ $indels[$i]->{'color'} } );
                $worksheet->write( $row + 1, $col + 2, '',
                    $indel_format->{ $indels[$i]->{'color'} } );
            }
            else {
                die;
            }
            $i++;
            $col += 3;
            next;
        }
        if ( $indels[$i]->{'position'} < $snps[$j]->{'position'} ) {
            if ( $col > 58 ) {
                $col = 1;
                $row += ( $align_cnt + 1 );
                $write_cycal = 0;
                while ( $write_cycal < $align_cnt ) {
                    $worksheet->write( $row + $write_cycal + 1,
                        0, $seq_names[$write_cycal] );
                    $write_cycal++;
                }
            }
            if ( $indels[$i]->{'type'} eq 'I' ) {
                $worksheet->write( $row, $col, ( $indels[$i]->{'position'} ),
                    $pos_format );
                $worksheet->write( $row, $col + 1, '-',
                    ( $snp_format->{'-'} ) );
                $worksheet->write(
                    $row,
                    $col + 2,
                    (         $indels[$i]->{'position'} 
                            + $indels[$i]->{'length'} - 1
                    ),
                    $pos_format
                );
                my @occur_temps = split //, $indels[$i]->{'occured'};
                unless ( scalar @occur_temps == $align_cnt ) {
                    die "indel occur error\n";
                }
                my $k = 0;
                while ( $k < $align_cnt ) {
                    if ( $occur_temps[$k] eq '0' ) {
                        my $temp = 'D' . $indels[$i]->{'length'};
                        $worksheet->write( $row + $k + 1,
                            $col + 1, $temp,
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col + 2, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                    }
                    elsif ( $occur_temps[$k] eq '1' ) {
                        my $temp = 'D' . $indels[$i]->{'length'};
                        $worksheet->write( $row + $k + 1,
                            $col + 1, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col + 2, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                    }
                    else {
                        die "indel type error 288\n";
                    }
                    $k++;
                }
            }
            elsif ( $indels[$i]->{'type'} eq 'D' ) {
                $worksheet->write( $row, $col, ( $indels[$i]->{'position'} ),
                    $pos_format );
                $worksheet->write( $row, $col + 1, '-',
                    ( $snp_format->{'-'} ) );
                $worksheet->write(
                    $row,
                    $col + 2,
                    (         $indels[$i]->{'position'} 
                            + $indels[$i]->{'length'} - 1
                    ),
                    $pos_format
                );
                my @occur_temps = split //, $indels[$i]->{'occured'};
                unless ( scalar @occur_temps == $align_cnt ) {
                    die "indel occur error\n";
                }
                my $k = 0;
                while ( $k < $align_cnt ) {
                    if ( $occur_temps[$k] eq '1' ) {
                        my $temp = 'D' . $indels[$i]->{'length'};
                        $worksheet->write( $row + $k + 1,
                            $col + 1, $temp,
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col + 2, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                    }
                    elsif ( $occur_temps[$k] eq '0' ) {
                        my $temp = 'D' . $indels[$i]->{'length'};
                        $worksheet->write( $row + $k + 1,
                            $col + 1, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                        $worksheet->write( $row + $k + 1,
                            $col + 2, '',
                            $indel_format->{ $indels[$i]->{'color'} } );
                    }
                    else {
                        die "indel type error 311,$occur_temps[$k]\n";
                    }
                    $k++;
                }
            }
            elsif ( $indels[$i]->{'type'} eq 'C' ) {
                $worksheet->write( $row, $col, ( $indels[$i]->{'position'} ),
                    $pos_format );
                $worksheet->write( $row, $col + 1, '-',
                    ( $snp_format->{'-'} ) );
                $worksheet->write(
                    $row,
                    $col + 2,
                    (         $indels[$i]->{'position'} 
                            + $indels[$i]->{'length'} - 1
                    ),
                    $pos_format
                );
                my $temp = 'C' . $indels[$i]->{'length'};
                $worksheet->write( $row + 1, $col + 1, $temp,
                    $indel_format->{ $indels[$i]->{'color'} } );
                $worksheet->write( $row + 1, $col, '',
                    $indel_format->{ $indels[$i]->{'color'} } );
                $worksheet->write( $row + 1, $col + 2, '',
                    $indel_format->{ $indels[$i]->{'color'} } );
            }
            else {
                die;
            }
            $i++;
            $col += 3;
        }
        elsif ( $indels[$i]->{'position'} > $snps[$j]->{'position'} ) {
            if ( $col > 60 ) {
                $col = 1;
                $row += ( $align_cnt + 1 );
                $write_cycal = 0;
                while ( $write_cycal < $align_cnt ) {
                    $worksheet->write( $row + $write_cycal + 1,
                        0, $seq_names[$write_cycal] );
                    $write_cycal++;
                }
            }
            my @smp_bases = split //, $snps[$j]->{'base'};
            $worksheet->write( $row, $col, ( $snps[$j]->{'position'} ),
                $pos_format );
            $write_cycal = 0;
            while ( $write_cycal < $align_cnt ) {
                $worksheet->write(
                    $row + $write_cycal + 1,
                    $col,
                    $smp_bases[$write_cycal],
                    $snp_format->{ $smp_bases[$write_cycal]
                            . $snps[$j]->{'color'} }
                );
                $write_cycal++;
            }
            $col++;
            $j++;
        }
        else {
            die;
        }
    }
    $col = 1;
    $i += ( $align_cnt + 1 );
}

my $i = 0;
while ( $i < $row ) {
    $worksheet->set_row( $i, 50 );
    $i += ( $align_cnt + 1 );
}
print "all done\n";
exit(0);
