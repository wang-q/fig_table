#!/usr/bin/perl
use strict;
use warnings;

use Template;
use YAML qw(Dump Load DumpFile LoadFile);

my $bat_dir = "d:/wq/Scripts/alignDB";

my @names = qw{
    Acetobacter_pasteurianus
    Acinetobacter_baumannii
    Actinobacillus_pleuropneumoniae
    Aggregatibacter_actinomycetemcomitans
    Alteromonas_macleodii
    Amycolatopsis_mediterranei
    Anaplasma_phagocytophilum
    Arcobacter_butzleri
    Azotobacter_vinelandii
    Bacillus_amyloliquefaciens
    Bacillus_anthracis
    Bacillus_cereus
    Bacillus_subtilis
    Bacillus_thuringiensis
    Bacteroides_fragilis
    Bifidobacterium_animalis
    Bifidobacterium_bifidum
    Bifidobacterium_longum
    Borrelia_burgdorferi
    Brucella_abortus
    Brucella_melitensis
    Brucella_suis
    Buchnera_aphidicola
    Burkholderia_cenocepacia
    Burkholderia_mallei
    Burkholderia_pseudomallei
    Campylobacter_jejuni
    Candidatus_Portiera_aleyrodidarum
    Candidatus_Sulcia_muelleri
    Chlamydia_pneumoniae
    Chlamydia_psittaci
    Chlamydia_trachomatis
    Clavibacter_michiganensis
    Clostridium_acetobutylicum
    Clostridium_botulinum
    Clostridium_perfringens
    Corynebacterium_diphtheriae
    Corynebacterium_glutamicum
    Corynebacterium_pseudotuberculosis
    Corynebacterium_ulcerans
    Coxiella_burnetii
    Cronobacter_sakazakii
    Dehalococcoides_mccartyi
    Desulfovibrio_vulgaris
    Dickeya_dadantii
    Edwardsiella_tarda
    Enterobacter_cloacae
    Enterococcus_faecalis
    Enterococcus_faecium
    Escherichia_coli
    Francisella_novicida
    Francisella_tularensis
    Fusobacterium_nucleatum
    Gardnerella_vaginalis
    Haemophilus_influenzae
    Helicobacter_pylori
    Klebsiella_pneumoniae
    Lactobacillus_acidophilus
    Lactobacillus_casei
    Lactobacillus_delbrueckii
    Lactobacillus_fermentum
    Lactobacillus_helveticus
    Lactobacillus_johnsonii
    Lactobacillus_plantarum
    Lactobacillus_reuteri
    Lactobacillus_rhamnosus
    Lactococcus_lactis
    Legionella_pneumophila
    Leptospira_interrogans
    Listeria_monocytogenes
    Mannheimia_haemolytica
    Methanococcus_maripaludis
    Methylobacterium_extorquens
    Mycobacterium_abscessus
    Mycobacterium_avium
    Mycobacterium_bovis
    Mycobacterium_canettii
    Mycobacterium_intracellulare
    Mycobacterium_tuberculosis
    Mycoplasma_bovis
    Mycoplasma_fermentans
    Mycoplasma_gallisepticum
    Mycoplasma_genitalium
    Mycoplasma_hyopneumoniae
    Mycoplasma_hyorhinis
    Mycoplasma_mycoides
    Mycoplasma_pneumoniae
    Neisseria_gonorrhoeae
    Neisseria_meningitidis
    Paenibacillus_mucilaginosus
    Paenibacillus_polymyxa
    Pantoea_ananatis
    Pasteurella_multocida
    Porphyromonas_gingivalis
    Prochlorococcus_marinus
    Propionibacterium_acnes
    Pseudomonas_aeruginosa
    Pseudomonas_fluorescens
    Pseudomonas_putida
    Pseudomonas_stutzeri
    Ralstonia_solanacearum
    Rhizobium_etli
    Rhizobium_leguminosarum
    Rhodobacter_sphaeroides
    Rhodopseudomonas_palustris
    Rickettsia_prowazekii
    Rickettsia_rickettsii
    Rickettsia_typhi
    Riemerella_anatipestifer
    Salmonella_enterica
    Serratia_plymuthica
    Shewanella_baltica
    Shigella_flexneri
    Sinorhizobium_meliloti
    Staphylococcus_aureus
    Stenotrophomonas_maltophilia
    Streptococcus_agalactiae
    Streptococcus_constellatus
    Streptococcus_dysgalactiae
    Streptococcus_equi
    Streptococcus_gallolyticus
    Streptococcus_intermedius
    Streptococcus_mutans
    Streptococcus_pneumoniae
    Streptococcus_pyogenes
    Streptococcus_salivarius
    Streptococcus_suis
    Streptococcus_thermophilus
    Sulfolobus_acidocaldarius
    Sulfolobus_islandicus
    Thermus_thermophilus
    Treponema_pallidum
    Variovorax_paradoxus
    Vibrio_cholerae
    Vibrio_vulnificus
    Xanthomonas_campestris
    Xanthomonas_oryzae
    Xylella_fastidiosa
    Yersinia_enterocolitica
    Yersinia_pestis
    Yersinia_pseudotuberculosis
    Zymomonas_mobilis
};

my @unused = qw{
    Amycolatopsis_mediterranei
    Anaplasma_phagocytophilum
    Azotobacter_vinelandii
    Bacillus_anthracis
    Brucella_abortus
    Brucella_melitensis
    Brucella_suis
    Buchnera_aphidicola
    Burkholderia_mallei
    Burkholderia_pseudomallei
    Candidatus_Portiera_aleyrodidarum
    Candidatus_Sulcia_muelleri
    Clavibacter_michiganensis
    Clostridium_acetobutylicum
    Fusobacterium_nucleatum
    Mannheimia_haemolytica
    Methylobacterium_extorquens
    Mycobacterium_avium
    Mycobacterium_bovis
    Mycoplasma_hyorhinis
    Mycoplasma_mycoides
    Mycoplasma_genitalium
    Mycobacterium_tuberculosis
    Mycoplasma_fermentans
    Mycoplasma_pneumoniae
    Rhodobacter_sphaeroides
    Rickettsia_prowazekii
    Rickettsia_rickettsii
    Rickettsia_typhi
    Shigella_flexneri
    Streptococcus_constellatus
    Sulfolobus_acidocaldarius
    Thermus_thermophilus
    Treponema_pallidum
    Yersinia_pestis
};
my %filter = map { $_ => 1 } @unused;

# turning example
my @example = qw{
    Borrelia_burgdorferi
    Burkholderia_cenocepacia
    Chlamydia_pneumoniae
    Lactobacillus_fermentum
    Salmonella_enterica
    Streptococcus_dysgalactiae
    Variovorax_paradoxus
};
my %filter_example = map { $_ => 1 } @example;

my @data;
for my $i ( 0 .. $#names ) {
    my $name = $names[$i];
    my $item = {
        name        => $name,
        text        => join( " ", split /_/, $name ),
        inter       => 0,
        common_file => "$name.common.chart.xlsx",
        gc_file     => "$name.gc.chart.xlsx",
    };

    push @data, $item;
}

my $tt = Template->new;
my $text;

$text = <<'EOF';
[% FOREACH item IN data -%]
[%   chart = 'common' -%]
[%  IF item.inter == 1;
        replace = '--replace diversity=divergence';
    ELSE;
        replace = '';
    END
-%]
REM [% item.name %]
if not exist [% item.name %].[% chart %].xlsx goto skip[% item.name %]
perl d:/wq/Scripts/alignDB/stat/[% chart %]_chart_factory.pl [% replace %] -i [% item.name %].[% chart %].xlsx
:skip[% item.name %]

[% END -%]
EOF
$tt->process( \$text, { data => \@data, }, "bac_common_chart_gr.bat" )
    or die Template->error;

$text = <<'EOF';
[% FOREACH item IN data -%]
[%  chart = 'gc' -%]
[%  IF item.inter == 1;
        replace = '--replace diversity=divergence';
    ELSE;
        replace = '';
    END
-%]
REM [% item.name %]
if not exist [% item.name %].[% chart %].xlsx goto skip[% item.name %]
perl d:/wq/Scripts/alignDB/stat/[% chart %]_chart_factory.pl [% replace %] --add_trend 1 -i [% item.name %].[% chart %].xlsx
:skip[% item.name %]

[% END -%]
EOF
$tt->process( \$text, { data => \@data, }, "bac_gc_chart_gr.bat" )
    or die Template->error;

$text = <<'EOF';
[% FOREACH item IN data -%]
REM [% item.name %]
perl [% bat_dir %]/fig/collect_common_basic.pl -d [% item.name %] -o [% item.name %].basicstat

[% END -%]
EOF
$tt->process(
    \$text,
    {   data    => \@data,
        bat_dir => $bat_dir,
    },
    "bac_collect_common_basic_paralog.bat"
) or die Template->error;

$text = <<'EOF';
[% FOREACH item IN data -%]
[%   chart = 'common' -%]
REM [% item.name %]
if not exist [% item.name %]_paralog.[% chart %].xlsx goto skip[% item.name %]
perl d:/wq/Scripts/alignDB/stat/[% chart %]_chart_factory.pl -i [% item.name %]_paralog.[% chart %].xlsx
:skip[% item.name %]

[% END -%]
EOF
$tt->process(
    \$text,
    {   data    => \@data,
        bat_dir => $bat_dir,
    },
    "bac_common_chart_paralog.bat"
) or die Template->error;

$text = <<'EOF';
[% FOREACH item IN data -%]
[%   chart = 'gc' -%]
REM [% item.name %]
if not exist [% item.name %]_paralog.[% chart %].xlsx goto skip[% item.name %]
perl d:/wq/Scripts/alignDB/stat/[% chart %]_chart_factory.pl  --add_trend 1 -i [% item.name %]_paralog.[% chart %].xlsx
:skip[% item.name %]

[% END -%]
EOF
$tt->process(
    \$text,
    {   data    => \@data,
        bat_dir => $bat_dir,
    },
    "bac_gc_chart_paralog.bat"
) or die Template->error;

$text = <<'EOF';
perl d:\wq\Scripts\alignDB\fig\collect_excel.pl [% FOREACH item IN data -%] -f [% item.name %]_paralog.common.xlsx -s d1_pi_gc_cv -n [% item.name %] [% END -%] -o bac_paralog_d1.xlsx

perl d:\wq\Scripts\alignDB\fig\collect_excel.pl [% FOREACH item IN data -%] -f [% item.name %]_paralog.common.xlsx -s d2_pi_gc_cv -n [% item.name %] [% END -%] -o bac_paralog_d2.xlsx

perl d:\wq\Scripts\alignDB\fig\collect_excel.pl [% FOREACH item IN data -%] -f [% item.name %]_paralog.common.xlsx -s d2_comb_pi_gc_cv -n [% item.name %] [% END -%] -o bac_paralog_d2_comb.xlsx

REM perl d:\wq\Scripts\alignDB\fig\ofg_chart.pl -i bac_paralog_d1.xlsx -xl "Distance to indels (d1)" -yl "Nucleotide diversity" -xr "A2:A8" -yr "B2:B8"  --y_min 0.0 --y_max 0.25 -x_min 0 -x_max 5 -rb "." -rs "NON_EXIST"


EOF
$tt->process(
    \$text,
    {   data    => \@data,
        bat_dir => $bat_dir,
    },
    "bac_collect_paralog.bat"
) or die Template->error;

$text = <<'EOF';
[% USE Math -%]
---
charts:
[% FOREACH item IN data -%]
  [% item.common_file %]:
    d1_comb_pi_gc_cv:
      4:
        - [% loop.index % 8 %]
        - [% Math.int(loop.index / 8) %]
[% END -%]
texts:
[% FOREACH item IN data -%]
  - text: [% item.text %]
    size: 8
    bold: 1
    italic: 1
    pos:
      - [% loop.index % 8 %]
      - [% Math.int(loop.index / 8) - 0.05 %]
[% END -%]
EOF

$tt->process( \$text, { data => [ grep { !$filter{ $_->{name} } } @data ], },
    'Fig_S_bac_d1_gc_cv_gr.yml' )
    or die Template->error;

$text = <<'EOF';
[% USE Math -%]
---
charts:
[% FOREACH item IN data -%]
  [% item.gc_file %]:
    segment_gc_indel_3:
      2:
        - [% loop.index % 8 %]
        - [% Math.int(loop.index / 8) %]
[% END -%]
texts:
[% FOREACH item IN data -%]
  - text: [% item.text %]
    size: 8
    bold: 1
    italic: 1
    pos:
      - [% loop.index % 8 %]
      - [% Math.int(loop.index / 8) - 0.05 %]
[% END -%]
EOF

$tt->process( \$text, { data => [ grep { !$filter{ $_->{name} } } @data ], },
    'Fig_S_bac_gc_indel_gr.yml' )
    or die Template->error;

$text = <<'EOF';
[% USE Math -%]
---
files:
[% FOREACH item IN data -%]
  - name: [% item.name %].window_gc.png
    pos:
      - [% loop.index % 8 %]
      - [% Math.int(loop.index / 8) %]
[% END -%]
texts:
[% FOREACH item IN data -%]
  - text: [% item.text %]
    size: 8
    bold: 1
    italic: 1
    pos:
      - [% loop.index % 8 %]
      - [% Math.int(loop.index / 8) - 0.05 %]
[% END -%]
EOF

$tt->process( \$text, { data => [ grep { !$filter{ $_->{name} } } @data ], },
    'Fig_S_bac_cv_indel_smooth.yml' )
    or die Template->error;

$text = <<'EOF';
[% USE Math -%]
---
charts:
[% FOREACH item IN data -%]
  [% item.gc_file %]:
    segment_gc_indel_3:
      2:
        - 0
        - [% loop.index %]
    segment_cv_indel_3:
      2:
        - 1
        - [% loop.index %]
[% END -%]
texts:
[% FOREACH item IN data -%]
  - text: [% item.text %]
    size: 8
    bold: 1
    italic: 1
    pos:
      - 0
      - [% loop.index - 0.05 %]
[% END -%]
EOF

$tt->process(
    \$text,
    { data => [ grep { $filter_example{ $_->{name} } } @data ], },
    'Fig_S_bac_gc_indel_example.yml'
) or die Template->error;

__END__
