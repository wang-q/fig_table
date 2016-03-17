#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use Getopt::Long qw(HelpMessage);
use FindBin;
use YAML qw(Dump Load DumpFile LoadFile);

use File::Find::Rule;
use Path::Tiny;

use Template;

#----------------------------------------------------------#
# GetOpt section
#----------------------------------------------------------#

=head1 SYNOPSIS

    perl collect_common_basic.pl -d d:\wq\GC\autochart\121125_saccharomyces\

=cut

GetOptions(
    'help|?' => sub { HelpMessage(0) },
    'dir|d=s' => \( my $dir = '.' ),
    'output|o=s' => \my $output,
) or HelpMessage(1);

#----------------------------------------------------------#
# init
#----------------------------------------------------------#
if ( !$output ) {
    $output = "basicstat";
}

$dir = path($dir)->absolute->stringify;
$output = path( $dir, "$output.yml" )->stringify;

my @xls_files
    = sort grep {/common|multi/i}
    File::Find::Rule->file->maxdepth(1)->name( '*.common.xlsx', '*.common.chart.xlsx' )->in($dir);

my @data;
for my $i ( 0 .. $#xls_files ) {
    my $file     = $xls_files[$i];
    my $basename = path($file)->basename( '.common.xlsx', '.common.chart.xlsx', );
    my $item     = {
        name => $basename,
        file => path($file)->basename,
    };
    push @data, $item;
}

my $tt   = Template->new;
my $text = <<'EOF';
---
autofit: A:J
texts:
  - text: "Name"
    pos: A1
  - text: "No. of strains"
    pos: B1
  - text: "Target length (Mb)"
    pos: C1
  - text: "Aligned length (Mb)"
    pos: D1
  - text: "Indels per 100 bp"
    pos: E1
  - text: "Substitutions per 100 bp"
    pos: F1
  - text: "D on average"
    pos: G1
  - text: "GC-content"
    pos: H1
  - text: "avg-align"
    pos: I1
  - text: "File"
    pos: J1
[% FOREACH item IN data -%]
  - text: [% item.name %]
    pos: A[% loop.index + 2%]
  - text: [% item.file %]
    pos: J[% loop.index + 2%]
[% END -%]
borders:
  - range: A1:J1
    top: 1
    bottom: 1
ranges:
[% FOREACH item IN data -%]
  [% item.file %]:
    basic:
      - copy: B2
        paste: B[% loop.index + 2%]
      - copy: B3
        paste: C[% loop.index + 2%]
      - copy: B4
        paste: D[% loop.index + 2%]
      - copy: B5
        paste: E[% loop.index + 2%]
      - copy: B6
        paste: F[% loop.index + 2%]
      - copy: B7
        paste: G[% loop.index + 2%]
      - copy: B8
        paste: H[% loop.index + 2%]
    summary:
      - copy: B2
        paste: I[% loop.index + 2%]
[% END -%]
EOF

$tt->process( \$text, { data => \@data, }, $output ) or die Template->error;
print "$output\n";

system("perl $FindBin::Bin/xlsx_table.pl -i $output");

__END__
