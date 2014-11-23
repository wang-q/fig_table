#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long;
use Pod::Usage;
use Config::Tiny;
use YAML qw(Dump Load DumpFile LoadFile);

use Statistics::R;
use List::MoreUtils qw(any all uniq zip);
use Text::CSV_XS;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#
my $file;
my $tag;
my $label;

my $x_var = 'window_gc';
my $y_var = 'flag';

my $device = 'png';

my $width  = 3;
my $height = 3;

my $man  = 0;
my $help = 0;

GetOptions(
    'help|?'   => \$help,
    'man'      => \$man,
    'f|file=s' => \$file,
    'tag=s'    => \$tag,
    'label'    => \$label,
    'x_var=s'  => \$x_var,
    'y_var=s'  => \$y_var,
    'device=s' => \$device,
    'width=s'  => \$width,
    'height=s' => \$height,
) or pod2usage(2);

pod2usage(1) if $help;
pod2usage( -exitstatus => 0, -verbose => 2 ) if $man;

{
    my $R = Statistics::R->new;

    $R->set( 'datafile', $file );
    $R->set( 'figfile',  "$tag.$x_var.$device" );
    $R->set( 'x_var',    $x_var );
    $R->set( 'y_var',    $y_var );

    $R->set( 'width',  $width );
    $R->set( 'height', $height );

    $R->run(q{ library(ggplot2) });
    $R->run(q{ library(scales) });
    $R->run(q{ library(gridExtra) });
    $R->run(
        q{
        plot_var <- function (plotdata, x_var, y_var) {
    
            plot <- ggplot(plotdata, aes_string(x=x_var, y=y_var)) +
                geom_point(shape=1,) + 
                geom_smooth(stat = "smooth", se=TRUE, size = 1) +
                theme_bw(base_size = 10)
            
            return (plot)
        }}
    );
    $R->run(q{ plotdata <- read.csv(datafile) });
    $R->run(qq{ plot <- plot_var(plotdata, x_var, y_var) });

    if ($label) {
        $R->run(qq{ plot <- plot + ggtitle("$tag") });
    }

    if ( $device =~ /pdf/ ) {
        $R->run( qq{ pdf(file=figfile, width=width, height=height) } );
    }
    elsif ( $device =~ /jpeg|tiff/ ) {
        $R->run(q{ library(R.devices) });
        $R->run(
            qq{ devNew("$device", file=figfile, width=width, height=height, units="in", res=300) }
        );
    }
    elsif ( $device =~ /png/ ) {
        $R->run(
            qq{ png( file=figfile, width=width, height=height, units="in", res=300) }
        );
    }
    else {
        die "Unrecognized device: [$device]\n";
    }
    $R->run(q{ print(plot) });
    $R->run(q{ dev.off() });
}

__END__

perl plot_smooth.pl -f bac_gr/Actinobacillus_pleuropneumoniae.csv -t Actinobacillus_pleuropneumoniae
