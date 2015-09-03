#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long;
use Pod::Usage;
use YAML qw(Dump Load DumpFile LoadFile);

use Win32::OLE qw(in);
use Win32::OLE::Const;
use Win32::OLE::Variant;
use Win32::OLE::NLS qw(:LOCALE :DATE);
use Win32::OLE::Const 'Microsoft Excel';

use File::Find::Rule;
use File::Spec;

$Win32::OLE::Warn = 3;    # die on errors...

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#
# running options
my $dir = '.';

my $suffix = "*.xlsx";

my $csv;

my $man  = 0;
my $help = 0;

GetOptions(
    'help|?'     => \$help,
    'man'        => \$man,
    'd|dir=s'    => \$dir,
    's|suffix=s' => \$suffix,
    'csv'        => \$csv,
) or pod2usage(2);

pod2usage(1) if $help;
pod2usage( -exitstatus => 0, -verbose => 2 ) if $man;

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
    $file = File::Spec->rel2abs($file);
    print $file, "\n";
    my $newbook = $excel->Workbooks->Open($file)
        or die "Cannot open xlsx file\n";
    my $outfile = $file;

    # xlExcel8    56 Excel8
    # xlExcel9795 43 Excel9795 # this doesn't work
    # xlCSV       6  CSV
    if ($csv) {
        $outfile =~ s/\.\w+$//i;
        $newbook->SaveAs( $outfile, 6 );
    }
    else {
        $outfile =~ s/\.\w+$/xls/i;
        $newbook->SaveAs( $outfile, 56 );
    }
}

$excel->Quit;

__END__

=head1 NAME

xlsx2xls.pl - convert xlsx to xls or csv

=head1 SYNOPSIS

    perl xlsx2xls.pl [options]
      Options:
        --help              brief help message
        --man               full documentation
        -d, --dir STR       dir containing xlsx files
        -s, --suffix STR    suffix, default is *.xlsx
        --csv               convert to csv

    perl xlsx2xls.pl -d stat -s *.chart.xlsx

=cut
