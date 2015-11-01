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
$Win32::OLE::Warn = 3;    # die on errors...

use File::Find::Rule;
use Path::Tiny;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

=head1 NAME

xlsx2xls.pl - convert xlsx to xls or csv

=head1 SYNOPSIS

    perl xlsx2xls.pl [options]
      Options:
        --help          -?          brief help message
        --dir           -d  STR     dir containing xlsx files
        --suffix        -s  STR     suffix, default is [*.xlsx]
        --sheet             STR     one sheet
        --csv                       convert to csv

    perl xlsx2xls.pl -d stat -s "*.chart.xlsx"

=cut

GetOptions(
    'help|?' => sub { HelpMessage(0) },
    'dir|d=s'    => \( my $dir    = '.' ),
    'suffix|s=s' => \( my $suffix = "*.xlsx" ),
    'csv'        => \my $csv,
    'sheet=s'    => \my $sheetnames,
) or HelpMessage(1);

#----------------------------------------------------------#
# init
#----------------------------------------------------------#
my $excel;    # excel object
unless ( $excel = Win32::OLE->new("Excel.Application") ) {
    die "Cannot init Excel.Application\n";
}
$excel->{DisplayAlerts} = 0;

my @files = File::Find::Rule->file->name($suffix)->in($dir);
printf "\n----Total $suffix Files: %4s----\n\n", scalar @files;

for my $file (@files) {
    $file = path($file)->absolute->stringify;
    print $file, "\n";
    my $newbook = $excel->Workbooks->Open($file)
        or die "Cannot open xlsx file\n";
    my $outfile = $file;

    # xlExcel8    56 Excel8
    # xlExcel9795 43 Excel9795 # this doesn't work
    # xlCSV       6  CSV
    if ($csv) {
        $outfile =~ s/\.\w+$/.csv/i;
        $newbook->SaveAs( $outfile, 6 );
    }
    else {
        $outfile =~ s/\.\w+$/.xls/i;
        $newbook->SaveAs( $outfile, 56 );
    }
}

$excel->Quit;

__END__
