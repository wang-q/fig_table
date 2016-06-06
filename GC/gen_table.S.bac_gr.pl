#!/usr/bin/perl
use strict;
use warnings;

use Template;
use YAML qw(Dump Load DumpFile LoadFile);

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

my @demo = qw{
    Actinobacillus_pleuropneumoniae
    Aggregatibacter_actinomycetemcomitans
    Alteromonas_macleodii
    Bacillus_amyloliquefaciens
    Bacillus_subtilis
    Bacteroides_fragilis
    Chlamydia_pneumoniae
    Chlamydia_trachomatis
    Coxiella_burnetii
    Dehalococcoides_mccartyi
    Gardnerella_vaginalis
    Lactobacillus_casei
    Lactobacillus_plantarum
    Lactobacillus_rhamnosus
    Paenibacillus_polymyxa
    Pasteurella_multocida
    Porphyromonas_gingivalis
    Shewanella_baltica
    Streptococcus_dysgalactiae
    Streptococcus_equi
    Streptococcus_pneumoniae
    Streptococcus_salivarius
    Streptococcus_suis
    Vibrio_cholerae
    Vibrio_vulnificus
    Yersinia_enterocolitica
    Yersinia_pseudotuberculosis
    Zymomonas_mobilis
};
my %filter_demo = map { $_ => 1 } @demo;

my @data;

for my $i ( 0 .. $#names ) {
    my $name = $names[$i];
    my $item = {
        name        => $name,
        text        => join( " ", split /_/, $name ),
        common_file => "$name.common.chart.xlsx",
        gc_file     => "$name.gc.chart.xlsx",
    };

    push @data, $item;
}

my $tt = Template->new;
my $text;

$text = <<'EOF';
autofit: A:C
texts:
  - text: "distance"
    pos: A1
  - text: "variable"
    pos: B1
  - text: "value"
    pos: C1
[% FOREACH item IN data -%]
[% curser = loop.index * 16 + 2 -%]
[% idx = 0 -%]
[% WHILE idx < 16 -%]
  - text: [% item.name %]
    pos: B[% curser + idx %]
[% idx = idx + 1 -%]
[% END -%]
[% END -%]
ranges:
[% FOREACH item IN data -%]
[% curser = loop.index * 16 + 2 -%]
  [% item.common_file %]:
    d1_pi_gc_cv:
      - copy: A3:A18
        paste: A[% curser %]
      - copy: D3:D18
        paste: C[% curser %]
[% END -%]
EOF

$tt->process( \$text,
    { data => [ grep { $filter_demo{ $_->{name} } } @data ], },
    'Table_for_combine_gr.yml' )
    or die Template->error;

$text = <<'EOF';
autofit: A:C
texts:
  - text: "distance"
    pos: A1
  - text: "variable"
    pos: B1
  - text: "value"
    pos: C1
[% FOREACH item IN data -%]
[% curser = loop.index * 16 + 2 -%]
[% idx = 0 -%]
[% WHILE idx < 16 -%]
  - text: [% item.name %]
    pos: B[% curser + idx %]
[% idx = idx + 1 -%]
[% END -%]
[% END -%]
ranges:
[% FOREACH item IN data -%]
[% curser = loop.index * 16 + 2 -%]
  [% item.common_file %]:
    d1_pi_gc_cv:
      - copy: A3:A18
        paste: A[% curser %]
      - copy: F3:F18
        paste: C[% curser %]
[% END -%]
EOF

$tt->process( \$text,
    { data => [ grep { $filter_demo{ $_->{name} } } @data ], },
    'Table_for_combine_gr_cv.yml' )
    or die Template->error;

$text = <<'EOF';
autofit: A:C
texts:
  - text: "distance"
    pos: A1
  - text: "variable"
    pos: B1
  - text: "value"
    pos: C1
[% FOREACH item IN data -%]
[% curser = loop.index * 16 + 2 -%]
[% idx = 0 -%]
[% WHILE idx < 16 -%]
  - text: [% item.name %]
    pos: B[% curser + idx %]
[% idx = idx + 1 -%]
[% END -%]
[% END -%]
ranges:
[% FOREACH item IN data -%]
[% curser = loop.index * 16 + 2 -%]
  [% item.common_file %]:
    d1_comb_pi_gc_cv:
      - copy: A3:A18
        paste: A[% curser %]
      - copy: D3:D18
        paste: C[% curser %]
[% END -%]
EOF

$tt->process(
    \$text,
    { data => [ grep { $filter_demo{ $_->{name} } } @data ], },
    'Table_for_combine_gr_comb.yml'
) or die Template->error;

#----------------------------#
# use linux eol for generating bash 
#----------------------------#
my $out_fh;
open $out_fh, '>:raw', 'bac_gsw_sql_query.sh';
$text = <<'EOF';
cd ~/data/gsw_logistic_regression

if [ -d bac_gr ]
then
    rm -fr bac_gr
fi

mkdir bac_gr
cd bac_gr

[% FOREACH item IN data -%]
echo [% item.name %]
perl ~/Scripts/alignDB/util/query_sql.pl -d [% item.name %] -f ../query_all.txt
[% END -%]

cd ~/data/gsw_logistic_regression

EOF

$tt->process(
    \$text,
    { data => [ @data ], },
    $out_fh
) or die Template->error;
close $out_fh;

open $out_fh, '>:raw', 'bac_gsw_logit_p.sh';
$text = <<'EOF';
cd ~/data/gsw_logistic_regression

perl logit_p.pl \
[% FOREACH item IN data -%]
    -f bac_gr/[% item.name %].csv -t [% item.name %] \
[% END -%]
    -gam \
    --prefix bac_gr_

EOF

$tt->process(
    \$text,
    { data => [ grep { !$filter{ $_->{name} } } @data ], },
    $out_fh
) or die Template->error;
close $out_fh;

open $out_fh, '>:raw', 'bac_gsw_plot_smooth.sh';
$text = <<'EOF';
cd ~/data/gsw_logistic_regression

if [ -d bac_gr_fig ]
then
    rm -fr bac_gr_fig
fi

mkdir bac_gr_fig
cd bac_gr_fig

[% FOREACH item IN data -%]
echo [% item.name %]
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/[% item.name %].csv -t [% item.name %] --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/[% item.name %].csv -t [% item.name %] --label -d pdf -x window_cv -y flag
[% END -%]

cd ~/data/gsw_logistic_regression

EOF

$tt->process(
    \$text,
    { data => [ grep { !$filter{ $_->{name} } } @data ], },
    $out_fh
) or die Template->error;
close $out_fh;

__END__
