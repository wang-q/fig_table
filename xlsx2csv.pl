#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long qw(HelpMessage);
use FindBin;
use YAML qw(Dump Load DumpFile LoadFile);

use Path::Tiny;
use Spreadsheet::XLSX;
use Text::CSV_XS;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

=head1 NAME

xlsx2csv.pl - convert xlsx to csv

=head1 SYNOPSIS

    perl xlsx2csv.pl -f <xlsx filename> [options]
      Options:
        --help          -?          brief help message
        --file          -f  STR     xlsx file
        --sheet             STR     one sheet name, default is the first sheet

    perl xlsx2csv.pl -f stat.xlsx

=cut

GetOptions(
    'help|?'   => sub { HelpMessage(0) },
    'file|f=s' => \( my $file_excel ),
    'sheet=s'  => \my $sheetname,
) or HelpMessage(1);

if ( !defined $file_excel ) {
    die HelpMessage(1);
}
elsif ( !path($file_excel)->is_file ) {
    die "Error: can't find file [$file_excel]";
}

#----------------------------------------------------------#
# init
#----------------------------------------------------------#

$file_excel = path($file_excel)->absolute->stringify;

my $excel  = Spreadsheet::XLSX->new($file_excel);
my $csv = Text::CSV_XS->new;

my @sheets = @{ $excel->{Worksheet} };
if ( !defined $sheetname ) {
    $sheetname = $sheets[0]->{Name};
}

for my $sheet (@sheets) {
    if ( $sheet->{Name} eq $sheetname ) {
        $sheet->{MaxRow} ||= $sheet->{MinRow};

        for my $row ( $sheet->{MinRow} .. $sheet->{MaxRow} ) {
            $sheet->{MaxCol} ||= $sheet->{MinCol};
            my @fields;
            for my $col ( $sheet->{MinCol} .. $sheet->{MaxCol} ) {
                my $cell = $sheet->{Cells}[$row][$col];
                push @fields, $cell->{Val};
            }
            $csv->say( *STDOUT, \@fields );
        }
    }
}

__END__
