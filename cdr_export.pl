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
use Win32::OLE::Const 'Corel - CorelDRAW 15.0 Type Library';

use Path::Class;
use File::Find::Rule;
use File::Spec;

$Win32::OLE::Warn = 3;    # die on errors...

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#
# running options
my $dir = '.';

my $resolution = 300;     # dpi
my $format     = 'png';

my $man  = 0;
my $help = 0;

GetOptions(
    'help|?'         => \$help,
    'man'            => \$man,
    'd|dir=s'        => \$dir,
    'r|resolution=s' => \$resolution,
    'f|format=s'     => \$format,
) or pod2usage(2);

pod2usage(1) if $help;
pod2usage( -exitstatus => 0, -verbose => 2 ) if $man;

#----------------------------------------------------------#
# init
#----------------------------------------------------------#
my @files = File::Find::Rule->file->name("*.cdr")->in($dir);
printf "\n----Total *.cdr Files: %4s----\n\n", scalar @files;

exit unless @files > 0;

my $cda;    # CorelDraw Application object
unless ( $cda = Win32::OLE->new("CorelDRAW.Application") ) {
    die "Cannot init CorelDRAW.Application\n";
}

my $cs = $cda->CorelScript;    # CorelScript object
while ( $cs->IsDocument ) {    #Close all currently open documents
    $cs->FileClose(0);
}

for my $file (@files) {
    $file = File::Spec->rel2abs($file);
    print $file, "\n";

    $cs->FileOpen($file) or die "Cannot open file [$file]\n";

    my $doc   = $cda->{ActiveDocument};    # corel document object
    my $layer = $cda->{ActiveLayer};

    my $FilterID;
    if ( $format eq 'png' ) {
        $FilterID = 802;
    }
    elsif ( $format eq 'emf' ) {
        $FilterID = 1300;
    }
    elsif ( $format eq 'ai' ) {
        $FilterID = 1305;
    }
    elsif ( $format eq 'pdf' ) {
        $FilterID = 1333;
    }
    next unless $FilterID;

    my $ImageType    = 4;    # 24-bit RGB color bitmap
    my $AntiAliasing = 1;    # Normal

    my $export = $file . ".$format";

    # Function FileExport(FileName As String, FilterID As Long, Width As Long,
    # Height As Long, XResolution As Long, YResolution As Long, ImageType As
    # Long, AntiAliasing As Long, Overwrite As Boolean, SelectionOnly As
    # Boolean) As Long
    #$cs->FileExport(
    #    $export,     $FilterID,   0,          0,
    #    $resolution, $resolution, $ImageType, $AntiAliasing,
    #    cdrTrue,     cdrFalse,
    #);

    # Sub Export(FileName As String, Filter As cdrFilter, [Range As
    # cdrExportRange = cdrCurrentPage], [Options As StructExportOptions],
    # [PaletteOptions As StructPaletteOptions])

    #my $opt = $cda->CreateStructExportOptions();
    #$opt->{AntiAliasingType} = cdrNormalAntiAliasing;
    #$opt->{ImageType}        = cdrRGBColorImage;
    #$opt->{ResolutionX}      = 97;
    #$opt->{ResolutionY}      = 97;
    #
    $doc->ExportBitmap( $export, cdrPNG, 1, 4, 0,
        0, 72, 72, cdrUndefined , cdrUndefined, cdrUndefined, cdrUndefined, cdrUndefined);


    $cs->FileClose;
}

#----------------------------#
# Change page settings
#----------------------------#
#$doc->{Unit}           = cdrMillimeter;
#$doc->{ReferencePoint} = cdrTopLeft;      # selected shape's topleft
#
## A4 210 * 297 mm
#$cda->{ActivePage}->SetSize( 210, 297 );
#$doc->{DrawingOriginX} = -105;
#$doc->{DrawingOriginY} = 148.5;

#----------------------------------------------------------#
# Cleanup and Save
#----------------------------------------------------------#

$cda->Quit;

__END__

=head1 SYNOPSIS

perl corel_fig.pl -i Fig.S1.yaml
