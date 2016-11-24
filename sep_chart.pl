#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long;
use YAML::Syck;

use List::Util;
use List::MoreUtils::PP;
use Path::Tiny;
use Spreadsheet::XLSX;
use Spreadsheet::ParseExcel;
use Statistics::R;
use App::Fasops::Common;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

=head1 SYNOPSIS

    perl sep_chart.pl -i Humanvsself.ofg.xlsx [options]
      Options:
        --help              -?          brief help message
        --input             -i  STR     input xlsx file
        --x_lab             -xl STR     X label
        --y_lab             -yl STR     Y label
        --x_range           -xr STR     X range
        --y_range           -yr STR     Y range
        --x_min                 STR
        --x_max                 STR
        --y_min                 STR
        --y_max                 STR
        --regex_background  -rt STR
        --regex_separate    -rs STR
        --mean_as_separate  -ms
        --filter_top        -ft INT     filter by average Y values
        --filter_bottom     -fb INT     filter by average Y values
        --postfix               STR
        --style_red                     use red square instead of blue diamond
        --style_dot                     background lines with dots
=cut

GetOptions(
    'help|?' => sub { Getopt::Long::HelpMessage(0) },
    'input|i=s'             => \( my $file_input       = 'Humanvsself.ofg.xlsx' ),
    'x_lab|xl=s'            => \( my $x_lab            = "X" ),
    'y_lab|yl=s'            => \( my $y_lab            = "Y" ),
    'x_range|xr=s'          => \( my $xrange           = "A2:A17" ),
    'y_range|yr=s'          => \( my $yrange           = "F2:F17" ),
    'x_min=s'               => \( my $x_min            = 0 ),
    'x_max=s'               => \( my $x_max            = 15 ),
    'y_min=s'               => \( my $y_min            = 0.4 ),
    'y_max=s'               => \( my $y_max            = 0.6 ),
    'regex_background|rb=s' => \( my $regex_background = "ofg_tag" ),
    'regex_separate|rs=s'   => \( my $regex_separate   = "ofg_all" ),
    'mean_as_separate|ms'   => \my $mean_as_separate,
    'filter_top|ft=i'       => \( my $filter_top       = 0 ),
    'filter_bottom|fb=i'    => \( my $filter_bottom    = 0 ),
    'postfix=s'             => \( my $postfix          = "" ),
    'style_red'             => \my $style_red,
    'style_dot'             => \my $style_dot,
) or Getopt::Long::HelpMessage(1);

#----------------------------------------------------------#
# init
#----------------------------------------------------------#
$file_input = path($file_input)->absolute->stringify;

my $name_base = $file_input;
$name_base =~ s/\.xlsx?$//;
$name_base =~ s{\\}{\/}g;
my $range_base = "${xrange}_${yrange}";
$range_base =~ s/://g;
$range_base =~ s/[^\w]/_/g;
$name_base = "${name_base}_${range_base}";
$name_base .= ".$postfix" if $postfix;

my $file_csv = "$name_base.csv";
path($file_csv)->remove;

my $file_chart = "$name_base.pdf";
path($file_chart)->remove;

#----------------------------------------------------------#
# data from xlsx to csv
#----------------------------------------------------------#
{
    my $excel;
    if ( $file_input =~ /\.xlsx$/ ) {
        $excel = Spreadsheet::XLSX->new($file_input);
    }
    else {
        $excel = Spreadsheet::ParseExcel->new->parse($file_input);
    }

    my @sheets            = $excel->worksheets;
    my @sheets_background = grep { $_->get_name =~ /$regex_background/ } @sheets;
    my @sheets_separate   = grep { $_->get_name =~ /$regex_separate/ } @sheets;

    # store average Y values for filtering
    my %avg_y_of = map { $_->get_name => 1 } @sheets_background;

    my @lines;    # output contents
    for my $sheet ( @sheets_background, @sheets_separate ) {
        my $sheetname = $sheet->get_name;
        printf "[sheet: %s]\n", $sheetname;

        printf "[range]\n";

        my @xs = values_in_range( $sheet, $xrange );
        my @ys = values_in_range( $sheet, $yrange );
        if ( @xs != @ys ) {
            warn "Unequal number for two columns\n";
        }

        my @groups = ( $avg_y_of{$sheetname} ? $sheetname : "separate_$sheetname" ) x scalar(@xs);
        $avg_y_of{$sheetname} = App::Fasops::Common::mean(@ys);

        my @zips = List::MoreUtils::PP::mesh @xs, @groups, @ys;

        my $it = List::MoreUtils::PP::natatime 3, @zips;
        while ( my @vals = $it->() ) {
            for (@vals) {
                $_ = '' if !defined $_;
            }
            push @lines, join( ",", @vals );
        }
    }

    #print YAML::Syck::Dump $ys_of_x;

    # filtering
    @sheets_background
        = sort { $avg_y_of{ $a->get_name } <=> $avg_y_of{ $b->get_name } } @sheets_background;
    if ($filter_bottom) {
        print "Filtering bottom values by $filter_bottom\n";
        for my $i ( 0 .. $filter_bottom - 1 ) {
            @lines = grep { $_ !~ /\,$sheets_background[$i]\,/ } @lines;
        }
    }
    if ($filter_top) {
        print "Filtering top values by $filter_top\n";
        for my $i ( 1 .. $filter_top ) {
            @lines = grep { $_ !~ /\,$sheets_background[-$i]\,/ } @lines;
        }
    }

    # calc mean
    if ($mean_as_separate) {
        my $ys_of_x = {};
        for (@lines) {
            my ( $x, undef, $y ) = split /,/;
            next if ( !defined $x or !defined $y );
            next if ( $x eq '' or $y eq '' );
            if ( !exists $ys_of_x->{$x} ) {
                $ys_of_x->{$x} = [$y];
            }
            else {
                push @{ $ys_of_x->{$x} }, $y;
            }
        }

        #print YAML::Syck::Dump $ys_of_x;

        for my $x ( sort { $a <=> $b } keys %{$ys_of_x} ) {
            my @ys   = @{ $ys_of_x->{$x} };
            my $mean = List::Util::sum(@ys) / scalar @ys;
            push @lines, join( ",", ( $x, 'separate_mean', $mean ) );
        }
    }

    open my $fh_csv, ">", $file_csv;
    print {$fh_csv} "X,group,Y\n";
    print {$fh_csv} "$_\n" for @lines;
    close $fh_csv;
}

{
    print "\nStart charting\n";
    my $R = Statistics::R->new;

    print "Passing variables\n";
    $R->set( 'file_csv',   $file_csv );
    $R->set( 'file_chart', $file_chart );
    $R->set( 'x_min',      $x_min );
    $R->set( 'x_max',      $x_max );
    $R->set( 'y_min',      $y_min );
    $R->set( 'y_max',      $y_max );

    # plotmath does not use curly brackets
    if ( $x_lab =~ /^(.+)(\{.+\})(.*)$/ ) {
        my $lab_pre  = $1;
        my $lab_exp  = $2;
        my $lab_post = $3;
        my $eval_code
            = qq{eval(parse( text = \"x_lab <- expression(paste(\\\"$lab_pre\\\", $lab_exp, \\\"$lab_post\\\"))\" ))};
        $R->run($eval_code);
    }
    else {
        $R->set( 'x_lab', $x_lab );
    }
    if ( $y_lab =~ /^(.+)(\{.+\})(.*)$/ ) {
        my $lab_pre  = $1;
        my $lab_exp  = $2;
        my $lab_post = $3;
        my $eval_code
            = qq{eval(parse( text = \"y_lab <- expression(paste(\\\"$lab_pre\\\", $lab_exp, \\\"$lab_post\\\"))\" ))};
        $R->run($eval_code);
    }
    else {
        $R->set( 'y_lab', $y_lab );
    }

    print "Run\n";

    # No newlines in the end of $r_code
    #@inject R
    my $r_code = <<'EOF';
        library(readr)
        library(dplyr)

        library(ggplot2)
        library(scales)
        library(gridExtra)
        library(extrafont)
        #loadfonts()

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

        mydata <- read_csv(file_csv, col_names = TRUE)
        
        mydata_main <- filter(mydata, ! grepl("separate", group))
        plot_main <- func_plot(mydata_main)

        mydata_sep <- filter(mydata, grepl("separate", group))
        plot_sep <- func_plot(mydata_sep)
        plot_sep <- plot_sep + 
            geom_line(colour="blue", size = 0.5) + 
            geom_point(colour="blue", fill="blue", shape=23)

        pdf(file_chart, family="Arial", width = 6, height = 3, useDingbats=FALSE)
        grid.arrange(plot_main, plot_sep, ncol=2, nrow=1)
        dev.off()
        embed_fonts(file_chart)
EOF

    if ( $^O eq "MSWin32" ) {
        $r_code =~ s{###Ghostscript}{Sys\.setenv\(R_GSCMD = "gswin32c\.exe"\)};
    }

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
}

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

sub values_in_range {
    my $sheet = shift;
    my $range = shift;

    my @values;

    my ( $row1, $col1, $row2, $col2 ) = range_to_rowcol($range);
    if ( $col1 != $col2 ) {
        warn "Range should contain only ONE column\n";
        return;
    }

    for my $row ( $row1 .. $row2 ) {
        my $value = $sheet->{Cells}[$row][$col1]->{Val};
        push @values, $value;
    }

    return @values;
}

__END__
