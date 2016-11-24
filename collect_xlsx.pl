#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long;
use YAML::Syck;

use List::MoreUtils::PP;
use Path::Tiny;
use Spreadsheet::XLSX;
use Spreadsheet::ParseExcel;
use Excel::Writer::XLSX;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

=head1 SYNOPSIS

    perl collect_xlsx.pl \
        -f Acetobacter_pasteurianus_paralog.common.xlsx \
        -s d2_pi_gc_cv \
        -n Acetobacter_pasteurianus

=cut

GetOptions(
    'help|?'    => sub { Getopt::Long::HelpMessage(0) },
    'file|f=s'  => \my @files_xlsx,
    'sheet|s=s' => \my @sheetnames,
    'name|n=s'  => \my @newnames,
    'output|o=s' => \( my $output = "collected.xlsx" ),
) or Getopt::Long::HelpMessage(1);

#----------------------------------------------------------#
# init
#----------------------------------------------------------#
$output = path($output)->absolute->stringify;
unlink $output if -e $output;
printf "Output filename is [%s]\n\n", $output;

my $newbook = Excel::Writer::XLSX->new($output);

# prepare
my @jobs;
{
    for (@newnames) {
        if ( length $_ > 30 ) {
            $_ = substr $_, 0, 30;
        }
    }
    my @args = List::MoreUtils::PP::mesh @files_xlsx, @sheetnames, @newnames;

    while ( scalar @args ) {
        push @jobs, [ splice @args, 0, 3 ];
    }
}

#----------------------------------------------------------#
# Paste every cells
#----------------------------------------------------------#
for my $i ( 0 .. $#jobs ) {
    my $filename = $jobs[$i]->[0];
    $filename = path($filename)->absolute->stringify;
    printf "[file: %s]\n", $filename;
    if ( !-e $filename ) {
        print " " x 4, "File not exists.\n";
        next;
    }

    my $excel;
    if ( $filename =~ /\.xlsx$/ ) {
        $excel = Spreadsheet::XLSX->new($filename);
    }
    else {
        $excel = Spreadsheet::ParseExcel->new->parse($filename);
    }

    my $sheetname = $jobs[$i]->[1];
    printf "[sheet: %s]\n", $sheetname;

    my @sheets = $excel->worksheets;
    if ( !grep { $_->get_name eq $sheetname } @sheets ) {
        print " " x 4, "sheet not exists!\n";
        next;
    }

    my $newname = $jobs[$i]->[2];

    #@type Excel::Writer::XLSX::Worksheet
    my $newsheet = $newbook->add_worksheet($newname);

    for my $sheet (@sheets) {
        if ( $sheet->get_name eq $sheetname ) {
            $sheet->{MaxRow} ||= $sheet->{MinRow};

            for my $row ( $sheet->{MinRow} .. $sheet->{MaxRow} ) {
                $sheet->{MaxCol} ||= $sheet->{MinCol};
                for my $col ( $sheet->{MinCol} .. $sheet->{MaxCol} ) {
                    my $cell = $sheet->{Cells}[$row][$col];

                    $newsheet->write( $row, $col, $cell->{Val}, );
                }
            }
        }
    }

    print "\n";
}

#----------------------------------------------------------#
# Finish
#----------------------------------------------------------#
$newbook->close;
exit;

__END__
