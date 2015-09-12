#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long;
use Pod::Usage;
use YAML qw(Dump Load DumpFile LoadFile);

use Path::Tiny;
use Statistics::R;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#
# running options
my $file_input;

my $x_lab = "X";
my $y_lab = "Y";

my $x_min = 0;
my $x_max = 15;

my $y_min = 0.4;
my $y_max = 0.6;

# use red square instead of blue diamond
my $style_red;

# background lines with dots
my $style_dot;

# convert tex to pdf
my $pdf;

my $man  = 0;
my $help = 0;

GetOptions(
    'help|?'     => \$help,
    'man'        => \$man,
    'i|input=s'  => \$file_input,
    'xl|x_lab=s' => \$x_lab,
    'yl|y_lab=s' => \$y_lab,
    'x_min=s'    => \$x_min,
    'x_max=s'    => \$x_max,
    'y_min=s'    => \$y_min,
    'y_max=s'    => \$y_max,
    'style_red'  => \$style_red,
    'style_dot'  => \$style_dot,
    'pdf'        => \$pdf,
) or pod2usage(2);

pod2usage(1) if $help;
pod2usage( -exitstatus => 0, -verbose => 2 ) if $man;

#----------------------------------------------------------#
# start
#----------------------------------------------------------#

my $name_base = path($file_input)->basename('.csv');

my $file_chart = "$name_base.tex";
path($file_chart)->remove;

{
    print "\nStart charting\n";
    my $R = Statistics::R->new;

    print "Passing variables\n";
    $R->set( 'file_csv',   $file_input );
    $R->set( 'file_chart', $file_chart );
    $R->set( 'x_lab',      $x_lab );
    $R->set( 'y_lab',      $y_lab );
    $R->set( 'x_min',      $x_min );
    $R->set( 'x_max',      $x_max );
    $R->set( 'y_min',      $y_min );
    $R->set( 'y_max',      $y_max );

    print "Run\n";

    # No newlines in the end of $r_code
    my $r_code = q{
        library(ggplot2)
        library(scales)
        library(gridExtra)
        library(extrafont)
        library(tikzDevice)
        options(tikzDefaultEngine = 'xetex')
        options(tikzDocumentDeclaration = "\\\\documentclass[10pt]{article}")
        
        options( 
            tikzXelatexPackages = c(
                "\\\\usepackage{tikz}\\n",
                "\\\\usepackage[active,tightpage,xetex]{preview}\\n",
                "\\\\usepackage{fontspec,xunicode}\\n",
                "\\\\PreviewEnvironment{pgfpicture}\\n",
                "\\\\setlength\\\\PreviewBorder{0pt}\\n",
                "\\\\setmainfont{Arial}"
            )
        )

        func_plot <- function (plotdata) {
            plot <- ggplot(data=plotdata, aes(x=X, y=Y, group=group)) +
                geom_line(colour="grey") +
                scale_x_continuous(labels = comma, limits=c(x_min, x_max)) + 
                scale_y_continuous(labels = comma, limits=c(y_min, y_max)) + 
                xlab(x_lab) + ylab(y_lab) + 
                theme_bw(base_size = 10) +
                guides(fill=FALSE) +
                theme(panel.grid.major.x = element_blank(), panel.grid.major.y = element_blank()) + 
                theme(panel.grid.minor.x = element_blank(), panel.grid.minor.y = element_blank())
            return(plot)
        }
        
        mydata <- read.csv(file_csv, header = TRUE)
        mydata$X <- as.numeric(mydata$X)
        rownames(mydata) <- NULL
        
        mydata_main <- subset(mydata, ! grepl("seperate", mydata$group))
        plot_main <- func_plot(mydata_main)
            
        
        mydata_sep <- subset(mydata, grepl("seperate", mydata$group))
        plot_sep <- func_plot(mydata_sep)
        plot_sep <- plot_sep + 
            geom_line(colour="blue", size = 0.5) + 
            geom_point(colour="blue", fill="blue", shape=23)
        
        tikz(file_chart, width = 6, height = 3, standAlone = T)
        grid.arrange(plot_main, plot_sep, ncol=2, nrow=1)
        dev.off()};

    if ($style_red) {
        $r_code =~ s{fill\=\"blue\"}{fill\=\"white\"}g;
        $r_code =~ s{\=\"blue\"}{\=\"\#C0504D\"}g;
        $r_code =~ s{shape\=23}{shape\=22}g;
    }
    if ($style_dot) {
        $r_code
            =~ s{(func_plot\(mydata_main\))}{$1 + geom_point(colour="grey", fill="grey", shape=21, size=1)};
    }

    $R->run($r_code);
    print $R->result;

    print "Finish charting\n";
    print Dump $R->get('file_chart');
    $R->stop;

    if ($pdf) {
        print "Call latexmk\n";
        system("latexmk -xelatex $name_base");
        system("latexmk -c");
    }
}

exit;

sub sheet_names {
    my $workbook = shift;

    my @sheet_names;
    for my $sheet ( in $workbook->Worksheets ) {
        push @sheet_names, $sheet->{Name};
    }

    return @sheet_names;
}

__END__

=head1 SYNOPSIS

Run this scripts under Mac

perl ofg_chart.pl -i Fig.S1.yaml
