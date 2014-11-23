#!/usr/bin/perl
use strict;
use warnings;

use Template;
use YAML qw(Dump Load DumpFile LoadFile);

my @cells = qw{
    AG04449 AG04450 AG09309 AG09319 AG10803 AOAF BJ CACO2 GM06990 GM12878 H1HESC
    H7ES HASP HBMEC HCF HCM HCPE HCT116 HEE HEK293 HELAS3 HEPG2 HL60 HMEC HMF
    HPAF HPF HRE HRPE HSMM HSMMt HUVEC HVMF JURKAT K562 NHA NHDFAD NHDFNEO NHEK
    NHLF NT2D1 OSTEO SAEC SKNSHRA U2OS
};

my @antibodies = qw {
    H2AZ H3K04ME1 H3K04ME2 H3K04ME3 H3K09AC H3K09ACb H3K09ME3 H3K27AC H3K27ME3
    H3K36ME3 H3K36ME3b H3K79ME2 H4K20ME1
};

my @data_cell;
for my $i ( 0 .. $#cells ) {
    my $name = $cells[$i];
    my $item = {
        name  => $name,
        inter => 1,
        file  => "Human_BED_Histone.tag.mg.chart.xlsx",
    };

    push @data_cell, $item;
}

my @data_antibody;
for my $i ( 0 .. $#antibodies ) {
    my $name = $antibodies[$i];
    my $item = {
        name  => $name,
        inter => 1,
        file  => "Human_BED_Histone.type.mg.chart.xlsx",
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
                "Human_BED_Histone.tt.mg.chart.xlsx",
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
      - copy: E2
        size: 8
        bold: 1
        pos :
          - [% loop.index % 4 + 0.5 %]
          - [% Math.int(loop.index / 4) - 0.05 %]
[% END -%]
EOF

$tt->process( \$text, { data => \@data_cell, }, 'Fig_encode_histone_cell.yml' )
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
      - copy: E2
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
    'Fig_encode_histone_antibody.yml'
) or die Template->error;

$text = <<'EOF';
[% USE Math -%]
---
charts:
  [% data.1.file %]:
[% FOREACH item IN data -%]
    ofg_tt_[% item.name.1 %]-[% item.name.0 %]:
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
      - copy: E2
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
    'Fig_encode_histone_cell_antibody.yml'
) or die Template->error;

__END__
