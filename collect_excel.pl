#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long qw(HelpMessage);
use FindBin;
use YAML qw(Dump Load DumpFile LoadFile);

use Win32::OLE qw(in);
use Win32::OLE::Const;
use Win32::OLE::Variant;
use Win32::OLE::NLS qw(:LOCALE :DATE);
use Win32::OLE::Const 'Microsoft Excel';

$Win32::OLE::Warn = 2;    # die on errors...

use List::MoreUtils qw(any all uniq zip);
use Path::Tiny;
use Set::Scalar;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

=head1 SYNOPSIS

    perl collect_xlsx.pl -f Acetobacter_pasteurianus_paralog.common.xlsx \
        -s d2_pi_gc_cv \
        -n Acetobacter_pasteurianus

=cut

GetOptions(
    'help|?'    => sub { HelpMessage(0) },
    'file|f=s'  => \my @files_xlsx,
    'sheet|s=s' => \my @sheetnames,
    'name|n=s'  => \my @newnames,
    'output|o=s' => \( my $output = "collected.xlsx" ),
) or HelpMessage(1);

#----------------------------------------------------------#
# init
#----------------------------------------------------------#
$output = path($output)->absolute->stringify;
unlink $output if -e $output;
printf "Output filename is [%s]\n\n", $output;

my $excel;    # excel object
unless ( $excel = Win32::OLE->new("Excel.Application") ) {
    die "Cannot init Excel.Application\n";
}

my $newbook = $excel->Workbooks->Add
    or die "Cannot create xls file\n";
$newbook->SaveAs($output);

for ( in $newbook->Worksheets ) {
    $_->Delete;
    $newbook->Worksheets->Count < 2 and last;
}

# prepare
for (@newnames) {
    if ( length $_ > 30 ) {
        $_ = substr $_, 0, 30;
    }
}
my @args = zip @files_xlsx, @sheetnames, @newnames;

my @jobs;
while ( scalar @args ) {
    push @jobs, [ splice @args, 0, 3 ];
}

#----------------------------------------------------------#
# Paste every ranges
#----------------------------------------------------------#
for my $i ( 0 .. $#jobs ) {
    my $filename = $jobs[$i]->[0];
    $filename = path($filename)->absolute->stringify;
    printf "[file: %s]\n", $filename;
    if ( !-e $filename ) {
        print " " x 4, "File not exists.\n";
        next;
    }

    # open copy xlsx file
    my $workbook;
    unless ( $workbook = $excel->Workbooks->Open($filename) ) {
        die "Cannot open xls file\n";
    }

    # get sheet
    my @sheets;
    for my $sheet ( in $workbook->Worksheets ) {
        push @sheets, $sheet->{Name};
    }
    my $name_set = Set::Scalar->new(@sheets);

    my $sheetname = $jobs[$i]->[1];
    printf "[sheet: %s]\n", $sheetname;
    if ( !$name_set->has($sheetname) ) {
        print " " x 4, "sheet not exists!\n";
        next;
    }

    my $sheet = $workbook->Worksheets($sheetname);
    $sheet->{UsedRange}->copy;

    # paste
    my $newname = $jobs[$i]->[2];
    printf "[newname: %s]\n", $newname;
    my $newsheet = $newbook->Worksheets->Add(
        { After => $newbook->Worksheets( $newbook->Worksheets->{Count} ) } );
    $newsheet->{Name} = $newname;
    $newsheet->Cells(1)->PasteSpecial;
    $newsheet->{UsedRange}->{Columns}->AutoFit;

    # clear clipboard
    $excel->{CutCopyMode} = 0;

    # close copy xlsx file
    $workbook->Close;

    print "\n";
}

#----------------------------------------------------------#
# Cleanup and Save
#----------------------------------------------------------#
$newbook->Worksheets(1)->Delete;
$newbook->Save;
$excel->Quit;

__END__
