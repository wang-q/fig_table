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
    H1HESC
    HELAS3
    HEPG2
    HUVEC
    K562
    NHA
    NHEK
};

my @antibodies = qw { AP2ALPHA AP2GAMMA ATF3 BAF155 BAF170 BATF BCL11A BCL3
    BCLAF1 BHLHE40 BRCA1 BRG1 CCNT2 CEBPB CFOS CHD2 CJUN CMYC CTBP2 CTCF CTCFc
    CTCFL E2F1 E2F4 E2F6 EBF EBF1 EGR1 ELF1 ELK4 ETS1 FOSe FOSL1 FOSL2 FOXA1
    FOXA2 GABP GATA1 GATA2 GATA2e GR GTF2B GTF2F1 HAE2F1 HDAC2SC6296 HMGN3 HNF4A
    HNF4G INI1 IRF1 IRF3 IRF4 JUNBe JUND JUNDe KAP1 MAFF MAFK MAFKb MAX MEF2A
    MEF2C Mxi1 NANOG NFE2 NFKB NFYA NFYB NRF1 NRSF Oct-2 P300 PAX5 PAX5b PBX3
    POL2 POL24H8 POL2S2 POU2F2 POU5F1 PRDM1 PU1 RAD21 RFX5 RPC155 RXRA SETDB1
    SIN3AK20 SIRT6 SIX5 SMC3 SP1 SP2 SREBP1 SRF STAT1 STAT2 STAT3 SUZ12 TAF1
    TAF7 TAL1 TBP TCF12 TF3C110 THAP1 TR4 USF1 USF2 WHIP YY1 YY1SC281 ZBTB33
    ZBTB7A ZEB1 ZNF143 ZNF263
};

my @data_cell;
for my $i ( 0 .. $#cells ) {
    my $name = $cells[$i];
    my $item = {
        name  => $name,
        inter => 1,
        file  => "Humanvsself_BED_cells_TFBS_SPP.cell.ofg.chart.xlsx",
    };

    push @data_cell, $item;
}

my @data_antibody;
for my $i ( 0 .. $#antibodies ) {
    my $name = $antibodies[$i];
    my $item = {
        name  => $name,
        inter => 1,
        file  => "Humanvsself_BED_cells_TFBS_SPP.antibody.ofg.chart.xlsx",
    };

    push @data_antibody, $item;
}

my @data_cell_antibody;
for my $i ( 0 .. $#cells ) {
    for my $j ( 0 .. $#antibodies ) {
        my $item = {
            name  => [ $antibodies[$j], $cells[$i] ],
            idx   => [ $j,              $i ],
            inter => 1,
            file =>
                "Humanvsself_BED_cells_TFBS_SPP.cell_antibody.ofg.chart.xlsx",
        };

        push @data_cell_antibody, $item;
    }
}

my $tt = Template->new;
my $text;

$text = <<'EOF';
[% USE Math -%]
---
charts:
  [% data.1.file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.name %]:
      1:
        - [% loop.index % 4 %]
        - [% Math.int(loop.index / 4) %]
[% END -%]
texts:
[% FOREACH item IN data -%]
  - text: [% item.name %]
    size: 8
    bold: 1
    pos:
      - [% loop.index % 4 %]
      - [% Math.int(loop.index / 4) - 0.05 %]
[% END -%]
ranges:
  [% data.1.file %]:
[% FOREACH item IN data -%]
    ofg_tag_[% item.name %]:
      - copy: L2
        size: 8
        bold: 1
        pos :
          - [% loop.index % 4 + 0.5 %]
          - [% Math.int(loop.index / 4) - 0.05 %]
[% END -%]
EOF

$tt->process( \$text, { data => \@data_cell, }, 'Fig_encode_tfbs_cell.yml' )
    or die Template->error;

$text = <<'EOF';
[% USE Math -%]
---
charts:
  [% data.1.file %]:
[% FOREACH item IN data -%]
    ofg_type_[% item.name %]:
      1:
        - [% loop.index % 4 %]
        - [% Math.int(loop.index / 4) %]
[% END -%]
texts:
[% FOREACH item IN data -%]
  - text: [% item.name %]
    size: 8
    bold: 1
    pos:
      - [% loop.index % 4 %]
      - [% Math.int(loop.index / 4) - 0.05 %]
[% END -%]
ranges:
  [% data.1.file %]:
[% FOREACH item IN data -%]
    ofg_type_[% item.name %]:
      - copy: L2
        size: 8
        bold: 1
        pos :
          - [% loop.index % 4 + 0.5 %]
          - [% Math.int(loop.index / 4) - 0.05 %]
[% END -%]
EOF

$tt->process(
    \$text,
    { data => \@data_antibody, },
    'Fig_encode_tfbs_antibody.yml'
) or die Template->error;

$text = <<'EOF';
[% USE Math -%]
---
charts:
  [% data.1.file %]:
[% FOREACH item IN data -%]
    ofg_tt_[% item.name.1 %]_[% item.name.0 %]:
      1:
        - [% item.idx.0 %]
        - [% item.idx.1 %]
[% END -%]
texts:
[% FOREACH item IN cells -%]
  - text: [% item %]
    size: 8
    bold: 1
    pos:
      - -0.3
      - [% loop.index + 0.5 %]
[% END -%]
[% FOREACH item IN antibodies -%]
  - text: [% item %]
    size: 8
    bold: 1
    pos:
      - [% loop.index + 0.3 %]
      - -0.1
[% END -%]
ranges:
  [% data.1.file %]:
[% FOREACH item IN data -%]
    ofg_tt_[% item.name.1 %]_[% item.name.0 %]:
      - copy: L2
        size: 8
        bold: 1
        pos :
          - [% item.idx.0 + 0.6 %]
          - [% item.idx.1 - 0.05 %]
[% END -%]
EOF

$tt->process(
    \$text,
    {   data       => \@data_cell_antibody,
        cells      => \@cells,
        antibodies => \@antibodies,
    },
    'Fig_encode_tfbs_cell_antibody.yml'
) or die Template->error;


__END__
