#!/usr/bin/perl
use strict;
use warnings;

use Template;
use YAML qw(Dump Load DumpFile LoadFile);

my @cells = qw{
    A549
    GLIOBLA
    GM12878
    GM12891
    GM12892
    GM18507
    GM19239
    H1HESC
    HELAS3
    HEPG2
    HTR8
    HUVEC
    K562
    MEDULLO
    NHA
    NHEK
    PANISLETS
    UROTHEL
};

my @data;
for my $i ( 0 .. $#cells ) {
    my $name = $cells[$i];
    my $text = $name;
    $text =~ s/\W/_/g;
    my $item = {
        name             => $name,
        text             => $text,
        inter            => 1,
        dnase_file       => "Humanvsself_BED_cells_DnaseSeq.ofg.chart.xlsx",
        faire_file       => "Humanvsself_BED_cells_FaireSeq.ofg.chart.xlsx",
        dnase_diff_file  => "Humanvsself_BED_diff_DnaseSeq.ofg.chart.xlsx",
        faire_diff_file  => "Humanvsself_BED_diff_FaireSeq.ofg.chart.xlsx",
        dnase_near_file  => "Humanvsself_BED_near_DnaseSeq.ofg.chart.xlsx",
        faire_near_file  => "Humanvsself_BED_near_FaireSeq.ofg.chart.xlsx",
        dnase_away_file  => "Humanvsself_BED_away_DnaseSeq.ofg.chart.xlsx",
        faire_away_file  => "Humanvsself_BED_away_FaireSeq.ofg.chart.xlsx",
        dnase_indel_file => "HumanvsCGOR_BED_DnaseSeq.ofg.chart.xlsx",
        faire_indel_file => "HumanvsCGOR_BED_FaireSeq.ofg.chart.xlsx",
    };

    push @data, $item;
}

#print Dump \@data;

my $tt = Template->new;
my $text;

$text = <<'EOF';
[% USE Math -%]
---
charts:
  [% data.1.dnase_file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.text %]:
      1:
        - 0
        - [% loop.index %]
[% END -%]
    ofg_all:
      1:
        - 0
        - [% data.size %]
  [% data.1.dnase_diff_file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.text %]:
      1:
        - 1
        - [% loop.index %]
[% END -%]
    ofg_all:
      1:
        - 1
        - [% data.size %]
  [% data.1.faire_file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.text %]:
      1:
        - 2
        - [% loop.index %]
[% END -%]
    ofg_all:
      1:
        - 2
        - [% data.size %]
  [% data.1.faire_diff_file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.text %]:
      1:
        - 3
        - [% loop.index %]
[% END -%]
    ofg_all:
      1:
        - 3
        - [% data.size %]
texts:
[% FOREACH item IN data -%]
  - text: [% item.name %]
    size: 10
    bold: 1
    pos:
      - -0.3
      - [% loop.index + 0.5 %]
[% END -%]
  - text: "All Cells"
    size: 10
    bold: 1
    pos:
      - -0.3
      - [% data.size + 0.5 %]
  - text: "DNaseSeq Peaks"
    size: 10
    bold: 1
    pos:
      - 0.5
      - -0.3
  - text: "All"
    size: 8
    bold: 1
    pos:
      - 0.5
      - -0.15
  - text: "Diff"
    size: 8
    bold: 1
    pos:
      - 1.5
      - -0.15
  - text: "FaireSeq Peaks"
    size: 10
    bold: 1
    pos:
      - 2.5
      - -0.3
  - text: "All"
    size: 8
    bold: 1
    pos:
      - 2.5
      - -0.15
  - text: "Diff"
    size: 8
    bold: 1
    pos:
      - 3.5
      - -0.15
EOF

$tt->process( \$text, { data => \@data, }, 'Fig_encode_dnase_faire_diff.yml' )
    or die Template->error;


$text = <<'EOF';
[% USE Math -%]
---
charts:
  [% data.1.dnase_near_file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.text %]:
      1:
        - 0
        - [% loop.index %]
[% END -%]
    ofg_all:
      1:
        - 0
        - [% data.size %]
  [% data.1.dnase_away_file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.text %]:
      1:
        - 1
        - [% loop.index %]
[% END -%]
    ofg_all:
      1:
        - 1
        - [% data.size %]
  [% data.1.faire_near_file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.text %]:
      1:
        - 2
        - [% loop.index %]
[% END -%]
    ofg_all:
      1:
        - 2
        - [% data.size %]
  [% data.1.faire_away_file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.text %]:
      1:
        - 3
        - [% loop.index %]
[% END -%]
    ofg_all:
      1:
        - 3
        - [% data.size %]
texts:
[% FOREACH item IN data -%]
  - text: [% item.name %]
    size: 10
    bold: 1
    pos:
      - -0.3
      - [% loop.index + 0.5 %]
[% END -%]
  - text: "All Cells"
    size: 10
    bold: 1
    pos:
      - -0.3
      - [% data.size + 0.5 %]
  - text: "DNaseSeq Peaks"
    size: 10
    bold: 1
    pos:
      - 0.5
      - -0.3
  - text: "Near genes"
    size: 8
    bold: 1
    pos:
      - 0.5
      - -0.15
  - text: "Away genes"
    size: 8
    bold: 1
    pos:
      - 1.5
      - -0.15
  - text: "FaireSeq Peaks"
    size: 10
    bold: 1
    pos:
      - 2.5
      - -0.3
  - text: "Near genes"
    size: 8
    bold: 1
    pos:
      - 2.5
      - -0.15
  - text: "Away genes"
    size: 8
    bold: 1
    pos:
      - 3.5
      - -0.15
EOF

$tt->process( \$text, { data => \@data, }, 'Fig_encode_dnase_faire_near_away.yml' )
    or die Template->error;

__END__
