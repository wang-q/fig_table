#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long;
use FindBin;
use YAML qw(Dump Load DumpFile LoadFile);

use Path::Tiny;
use Spreadsheet::XLSX;
use Spreadsheet::ParseExcel;
use Excel::Writer::XLSX;
use Set::Scalar;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

=head1 SYNOPSIS

    perl xlsx_table.pl -i Table.S1.yaml

=cut

GetOptions(
    'help|?' => sub { Getopt::Long::HelpMessage(0) },
    'input|i=s' => \( my $file_input = 'Table.S1.yaml' ),
    'font=s'    => \( my $font_name  = 'Arial' ),
    'size=i'    => \( my $font_size  = 10 ),
) or Getopt::Long::HelpMessage(1);

#----------------------------------------------------------#
# init
#----------------------------------------------------------#
# The structure of yaml file:
# filename:sheetname:chart_serial:[x, y] coordinates
my $dispatch = LoadFile($file_input);
my $ranges   = $dispatch->{ranges};
my $texts    = $dispatch->{texts};
my $borders  = $dispatch->{borders};

# Excel files should be located in the same dir as the yaml file.
# new excel table file will be named after yaml file.
#@type Path::Tiny
my $file_yaml = path($file_input);
$file_yaml = $file_yaml->absolute;
my $base_dir = $file_yaml->parent->stringify;
my $newfile  = $file_yaml->stringify;
$newfile =~ s/\.ya?ml$/.xlsx/;
unlink $newfile if -e $newfile;

my $newbook = Excel::Writer::XLSX->new($newfile);
my $newname = $file_yaml->basename( ".yaml", ".yml" );
$newname =~ s/[^\w]/_/g;
if ( length $newname > 30 ) {
    $newname = substr $newname, 0, 20;
}

#@type Excel::Writer::XLSX::Worksheet
my $newsheet = $newbook->add_worksheet($newname);

#----------------------------#
# Formats
#----------------------------#
my %font = (
    font => $font_name,
    size => $font_size,
);
my $format = { NORMAL => $newbook->add_format( color => 'black', %font, ), };
my $format_set = {};

for my $i ( 0 .. scalar @{$borders} - 1 ) {
    printf "[Borders]\n";

    my $range = $borders->[$i]{range};
    printf " " x 4 . "[%s]\n", $range;

    my ( $row1, $col1, $row2, $col2 ) = range_to_rowcol($range);
    my $set = Set::Scalar->new;
    for my $row ( $row1 .. $row2 ) {
        for my $col ( $col1 .. $col2 ) {
            $set->insert("$row-$col");
        }
    }
    $format_set->{$i} = $set;

    $format->{$i} = $newbook->add_format( color => 'black', %font, );
    if ( $borders->[$i]{top} ) {
        $format->{$i}->set_top(1);
    }
    if ( $borders->[$i]{bottom} ) {
        $format->{$i}->set_bottom(1);
    }
    if ( $borders->[$i]{left} ) {
        $format->{$i}->set_left(1);
    }
    if ( $borders->[$i]{right} ) {
        $format->{$i}->set_right(1);
    }
}

#----------------------------------------------------------#
# Paste ranges
#----------------------------------------------------------#
for my $filename ( sort keys %{$ranges} ) {
    printf "[file: %s]\n", $filename;

    # open xls(x) file
    my $efile = path( $base_dir, $filename )->stringify;
    if ( !-e $efile ) {
        warn "File not exists: $efile\n";
        next;
    }
    my $workbook;
    if ( $efile =~ /\.xlsx$/ ) {
        $workbook = Spreadsheet::XLSX->new($efile);
    }
    else {
        $workbook = Spreadsheet::ParseExcel->new->parse($efile);
    }

    for my $sheetname ( sort keys %{ $ranges->{$filename} } ) {
        printf "[sheet: %s]\n", $sheetname;

        # get sheet
        my @sheets = $workbook->worksheets;

        for my $sheet (@sheets) {
            if ( $sheet->get_name eq $sheetname ) {

                for my $range ( @{ $ranges->{$filename}{$sheetname} } ) {
                    my $copy_range = $range->{copy};
                    printf " " x 4 . "[%s]\n", $copy_range;

                    my ( $row1, $col1, $row2, $col2 ) = range_to_rowcol($copy_range);
                    if ( $col1 != $col2 ) {
                        warn "Range should contain only ONE column\n";
                        next;
                    }

                    my $paste_range = $range->{paste};
                    my ( $rowp, $colp ) = cell_to_rowcol($paste_range);

                    for my $row ( $row1 .. $row2 ) {
                        my $value = $sheet->{Cells}[$row][$col1]->{Val};
                        my $flag  = "NORMAL";
                        for my $i ( keys %{$format_set} ) {
                            if ( $format_set->{$i}->has("$row-$col1") ) {
                                $flag = $i;
                                last;
                            }
                        }

                        $newsheet->write( $rowp, $colp, $value, $format->{$flag} );
                        $rowp++;
                    }
                }
            }
        }
    }
}

#----------------------------------------------------------#
# Write texts
#----------------------------------------------------------#
for my $t ( @{$texts} ) {
    my $text = $t->{text};
    my $pos  = $t->{pos};

    printf "[text: %s]\n", $text;

    my ( $row1, $col1, $row2, $col2 ) = range_to_rowcol($pos);
    my $flag = "NORMAL";
    for my $i ( keys %{$format_set} ) {
        if ( $format_set->{$i}->has("$row1-$col1") ) {
            $flag = $i;
            last;
        }
    }

    if ( ( $row1 != $row2 ) or ( $col1 != $col2 ) ) {
        $newsheet->merge_range( $row1, $col1, $row2, $col2, $text, $format->{$flag} );
    }
    else {
        $newsheet->write( $row1, $col1, $text, $format->{$flag} );
    }
}

#----------------------------------------------------------#
# Finish
#----------------------------------------------------------#
$newbook->close;
exit;

#----------------------------------------------------------#
# Subroutines
#----------------------------------------------------------#
sub range_to_rowcol {
    my $range = shift;

    my @cell = split /:/, $range;

    if ( @cell == 1 ) {
        return cell_to_rowcol( $cell[0] ), cell_to_rowcol( $cell[0] );
    }
    elsif ( @cell == 2 ) {
        return cell_to_rowcol( $cell[0] ), cell_to_rowcol( $cell[1] );
    }
    else {
        return ( 0, 0, 0, 0 );
    }
}

sub cell_to_rowcol {
    my $cell = shift;

    return ( 0, 0 ) unless $cell;

    $cell =~ /([A-Z]{1,3})(\d+)/;

    my $col = $1;
    my $row = $2;

    # Convert base26 column string to number
    my @chars = split //, $col;
    my $expn = 0;
    $col = 0;

    while (@chars) {
        my $char = pop(@chars);    # LS char first
        $col += ( ord($char) - ord('A') + 1 ) * ( 26**$expn );
        $expn++;
    }

    # Convert 1-index to zero-index
    $row--;
    $col--;

    return ( $row, $col );
}

__END__
