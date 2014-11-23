#!/usr/bin/perl
use strict;
use warnings;

use File::Basename;
use Template;
use YAML qw(Dump Load DumpFile LoadFile);

my $level_of = {
    0 => '10k',
    1 => '5k',
    2 => '1k',
    3 => '0.5k',
};

my $tt = Template->new;
my $text;

$text = <<'EOF';
---
charts:
  HumanvsChimp.gc.chart.xlsx:
[% FOREACH i IN level_of.keys.sort -%]
    segment_gc_indel_[% i %]:
      1:
        - 0
        - [% loop.index %]
      2:
        - 1
        - [% loop.index %]
    segment_cv_indel_[% i %]:
      1:
        - 2
        - [% loop.index %]
      2:
        - 3
        - [% loop.index %]
[% END -%]
  Nipvs9311.gc.chart.xlsx:
[% FOREACH i IN level_of.keys.sort -%]
    segment_gc_indel_[% i %]:
      1:
        - 0
        - [% loop.index + 4 %]
      2:
        - 1
        - [% loop.index + 4 %]
    segment_cv_indel_[% i %]:
      1:
        - 2
        - [% loop.index + 4 %]
      2:
        - 3
        - [% loop.index + 4 %]
[% END -%]
texts:
[% FOREACH i IN level_of.keys.sort -%]
  - text: "[% lables.shift %]) Human versus Chimpanzee [% level_of.$i %]"
    size: 8
    bold: 1
    italic: 0
    rotate: 0
    pos:
      - 0
      - [% loop.index - 0.05 %]
[% END -%]
[% FOREACH i IN level_of.keys.sort -%]
  - text: "[% lables.shift %]) Nipponbare versus 9311 [% level_of.$i %]"
    size: 8
    bold: 1
    italic: 0
    rotate: 0
    pos:
      - 0
      - [% loop.index + 4 - 0.05 %]
[% END -%]

EOF
$tt->process(
    \$text,
    { level_of => $level_of, lables => [ 'a' .. 'z' ] },
    "Fig.human_rice_levels_10k.yml"
) or die Template->error;

$text = <<'EOF';
---
charts:
  HumanvsChimp.gc.chart.xlsx:
[% FOREACH i IN level_of.keys.sort -%]
    segment_gc_indel_[% i %]:
      1:
        - 0
        - [% loop.index %]
      2:
        - 1
        - [% loop.index %]
    segment_cv_indel_[% i %]:
      1:
        - 2
        - [% loop.index %]
      2:
        - 3
        - [% loop.index %]
    segment_std_indel_[% i %]:
      1:
        - 0
        - [% loop.index + 4 %]
      2:
        - 1
        - [% loop.index + 4%]
    segment_mdcw_indel_[% i %]:
      1:
        - 2
        - [% loop.index + 4 %]
      2:
        - 3
        - [% loop.index + 4%]
[% END -%]
texts:
[% FOREACH i IN level_of.keys.sort -%]
  - text: "GC [% level_of.$i %]"
    size: 8
    bold: 1
    italic: 0
    rotate: 0
    pos:
      - 0
      - [% loop.index - 0.05 %]
  - text: "CV [% level_of.$i %]"
    size: 8
    bold: 1
    italic: 0
    rotate: 0
    pos:
      - 2
      - [% loop.index - 0.05 %]
  - text: "STD [% level_of.$i %]"
    size: 8
    bold: 1
    italic: 0
    rotate: 0
    pos:
      - 0
      - [% loop.index + 4 - 0.05 %]
  - text: "MDCW [% level_of.$i %]"
    size: 8
    bold: 1
    italic: 0
    rotate: 0
    pos:
      - 2
      - [% loop.index + 4 - 0.05 %]
[% END -%]

EOF
$tt->process(
    \$text,
    { level_of => $level_of, lables => [ 'a' .. 'z' ] },
    "Fig.human_para_levels_10k.yml"
) or die Template->error;

__END__
