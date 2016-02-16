#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long qw(HelpMessage);
use FindBin;
use YAML qw(Dump Load DumpFile LoadFile);

use Win32::OLE qw(in with);
use Win32::OLE::Const;
use Win32::OLE::Variant;
use Win32::OLE::NLS qw(:LOCALE :DATE);
use Win32::OLE::Const 'Microsoft Excel';

$Win32::OLE::Warn = 2;    # die on errors...

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

=head1 SYNOPSIS

    perl print_xlsx.pl -i 1.xlsx

=cut

GetOptions(
    'help|?' => sub { HelpMessage(0) },
    'input|i=s' => \my $file_xlsx,
) or HelpMessage(1);

#----------------------------------------------------------#
# init
#----------------------------------------------------------#
my $excel;    # excel object
unless ( $excel = Win32::OLE->new("Excel.Application") ) {
    die "Cannot init Excel.Application\n";
}

my $workbook  = $excel->Workbooks->Open($file_xlsx);
my $sheet     = $workbook->Worksheets(1);
with(
    $sheet->PageSetup,
    Orientation    => xlLandscape,
    FitToPagesWide => 1,
    FitToPagesTall => 1,
    PaperSize      => xlPaperA4,
    Zoom           => Variant(VT_BOOL, 0),
);
my $pobj = $excel->ActivePrinter;
if ($pobj) {
    print "start - Name of default printer => $pobj \n";
}
$pobj = $excel->ActivePrinter;
if ($pobj) {
    print "after setting - Name of default printer => $pobj \n";
}
$workbook->PrintOut();
$workbook->Close(0);

$excel->Quit;
