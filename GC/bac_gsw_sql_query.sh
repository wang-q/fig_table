cd ~/data/gsw_logistic_regression

if [ -d bac_gr ]
then
    rm -fr bac_gr
fi

mkdir bac_gr
cd bac_gr

echo Acetobacter_pasteurianus
perl ~/Scripts/alignDB/util/query_sql.pl -d Acetobacter_pasteurianus -f ../query_all.txt
echo Acinetobacter_baumannii
perl ~/Scripts/alignDB/util/query_sql.pl -d Acinetobacter_baumannii -f ../query_all.txt
echo Actinobacillus_pleuropneumoniae
perl ~/Scripts/alignDB/util/query_sql.pl -d Actinobacillus_pleuropneumoniae -f ../query_all.txt
echo Aggregatibacter_actinomycetemcomitans
perl ~/Scripts/alignDB/util/query_sql.pl -d Aggregatibacter_actinomycetemcomitans -f ../query_all.txt
echo Alteromonas_macleodii
perl ~/Scripts/alignDB/util/query_sql.pl -d Alteromonas_macleodii -f ../query_all.txt
echo Amycolatopsis_mediterranei
perl ~/Scripts/alignDB/util/query_sql.pl -d Amycolatopsis_mediterranei -f ../query_all.txt
echo Anaplasma_phagocytophilum
perl ~/Scripts/alignDB/util/query_sql.pl -d Anaplasma_phagocytophilum -f ../query_all.txt
echo Arcobacter_butzleri
perl ~/Scripts/alignDB/util/query_sql.pl -d Arcobacter_butzleri -f ../query_all.txt
echo Azotobacter_vinelandii
perl ~/Scripts/alignDB/util/query_sql.pl -d Azotobacter_vinelandii -f ../query_all.txt
echo Bacillus_amyloliquefaciens
perl ~/Scripts/alignDB/util/query_sql.pl -d Bacillus_amyloliquefaciens -f ../query_all.txt
echo Bacillus_anthracis
perl ~/Scripts/alignDB/util/query_sql.pl -d Bacillus_anthracis -f ../query_all.txt
echo Bacillus_cereus
perl ~/Scripts/alignDB/util/query_sql.pl -d Bacillus_cereus -f ../query_all.txt
echo Bacillus_subtilis
perl ~/Scripts/alignDB/util/query_sql.pl -d Bacillus_subtilis -f ../query_all.txt
echo Bacillus_thuringiensis
perl ~/Scripts/alignDB/util/query_sql.pl -d Bacillus_thuringiensis -f ../query_all.txt
echo Bacteroides_fragilis
perl ~/Scripts/alignDB/util/query_sql.pl -d Bacteroides_fragilis -f ../query_all.txt
echo Bifidobacterium_animalis
perl ~/Scripts/alignDB/util/query_sql.pl -d Bifidobacterium_animalis -f ../query_all.txt
echo Bifidobacterium_bifidum
perl ~/Scripts/alignDB/util/query_sql.pl -d Bifidobacterium_bifidum -f ../query_all.txt
echo Bifidobacterium_longum
perl ~/Scripts/alignDB/util/query_sql.pl -d Bifidobacterium_longum -f ../query_all.txt
echo Borrelia_burgdorferi
perl ~/Scripts/alignDB/util/query_sql.pl -d Borrelia_burgdorferi -f ../query_all.txt
echo Brucella_abortus
perl ~/Scripts/alignDB/util/query_sql.pl -d Brucella_abortus -f ../query_all.txt
echo Brucella_melitensis
perl ~/Scripts/alignDB/util/query_sql.pl -d Brucella_melitensis -f ../query_all.txt
echo Brucella_suis
perl ~/Scripts/alignDB/util/query_sql.pl -d Brucella_suis -f ../query_all.txt
echo Buchnera_aphidicola
perl ~/Scripts/alignDB/util/query_sql.pl -d Buchnera_aphidicola -f ../query_all.txt
echo Burkholderia_cenocepacia
perl ~/Scripts/alignDB/util/query_sql.pl -d Burkholderia_cenocepacia -f ../query_all.txt
echo Burkholderia_mallei
perl ~/Scripts/alignDB/util/query_sql.pl -d Burkholderia_mallei -f ../query_all.txt
echo Burkholderia_pseudomallei
perl ~/Scripts/alignDB/util/query_sql.pl -d Burkholderia_pseudomallei -f ../query_all.txt
echo Campylobacter_jejuni
perl ~/Scripts/alignDB/util/query_sql.pl -d Campylobacter_jejuni -f ../query_all.txt
echo Candidatus_Portiera_aleyrodidarum
perl ~/Scripts/alignDB/util/query_sql.pl -d Candidatus_Portiera_aleyrodidarum -f ../query_all.txt
echo Candidatus_Sulcia_muelleri
perl ~/Scripts/alignDB/util/query_sql.pl -d Candidatus_Sulcia_muelleri -f ../query_all.txt
echo Chlamydia_pneumoniae
perl ~/Scripts/alignDB/util/query_sql.pl -d Chlamydia_pneumoniae -f ../query_all.txt
echo Chlamydia_psittaci
perl ~/Scripts/alignDB/util/query_sql.pl -d Chlamydia_psittaci -f ../query_all.txt
echo Chlamydia_trachomatis
perl ~/Scripts/alignDB/util/query_sql.pl -d Chlamydia_trachomatis -f ../query_all.txt
echo Clavibacter_michiganensis
perl ~/Scripts/alignDB/util/query_sql.pl -d Clavibacter_michiganensis -f ../query_all.txt
echo Clostridium_acetobutylicum
perl ~/Scripts/alignDB/util/query_sql.pl -d Clostridium_acetobutylicum -f ../query_all.txt
echo Clostridium_botulinum
perl ~/Scripts/alignDB/util/query_sql.pl -d Clostridium_botulinum -f ../query_all.txt
echo Clostridium_perfringens
perl ~/Scripts/alignDB/util/query_sql.pl -d Clostridium_perfringens -f ../query_all.txt
echo Corynebacterium_diphtheriae
perl ~/Scripts/alignDB/util/query_sql.pl -d Corynebacterium_diphtheriae -f ../query_all.txt
echo Corynebacterium_glutamicum
perl ~/Scripts/alignDB/util/query_sql.pl -d Corynebacterium_glutamicum -f ../query_all.txt
echo Corynebacterium_pseudotuberculosis
perl ~/Scripts/alignDB/util/query_sql.pl -d Corynebacterium_pseudotuberculosis -f ../query_all.txt
echo Corynebacterium_ulcerans
perl ~/Scripts/alignDB/util/query_sql.pl -d Corynebacterium_ulcerans -f ../query_all.txt
echo Coxiella_burnetii
perl ~/Scripts/alignDB/util/query_sql.pl -d Coxiella_burnetii -f ../query_all.txt
echo Cronobacter_sakazakii
perl ~/Scripts/alignDB/util/query_sql.pl -d Cronobacter_sakazakii -f ../query_all.txt
echo Dehalococcoides_mccartyi
perl ~/Scripts/alignDB/util/query_sql.pl -d Dehalococcoides_mccartyi -f ../query_all.txt
echo Desulfovibrio_vulgaris
perl ~/Scripts/alignDB/util/query_sql.pl -d Desulfovibrio_vulgaris -f ../query_all.txt
echo Dickeya_dadantii
perl ~/Scripts/alignDB/util/query_sql.pl -d Dickeya_dadantii -f ../query_all.txt
echo Edwardsiella_tarda
perl ~/Scripts/alignDB/util/query_sql.pl -d Edwardsiella_tarda -f ../query_all.txt
echo Enterobacter_cloacae
perl ~/Scripts/alignDB/util/query_sql.pl -d Enterobacter_cloacae -f ../query_all.txt
echo Enterococcus_faecalis
perl ~/Scripts/alignDB/util/query_sql.pl -d Enterococcus_faecalis -f ../query_all.txt
echo Enterococcus_faecium
perl ~/Scripts/alignDB/util/query_sql.pl -d Enterococcus_faecium -f ../query_all.txt
echo Escherichia_coli
perl ~/Scripts/alignDB/util/query_sql.pl -d Escherichia_coli -f ../query_all.txt
echo Francisella_novicida
perl ~/Scripts/alignDB/util/query_sql.pl -d Francisella_novicida -f ../query_all.txt
echo Francisella_tularensis
perl ~/Scripts/alignDB/util/query_sql.pl -d Francisella_tularensis -f ../query_all.txt
echo Fusobacterium_nucleatum
perl ~/Scripts/alignDB/util/query_sql.pl -d Fusobacterium_nucleatum -f ../query_all.txt
echo Gardnerella_vaginalis
perl ~/Scripts/alignDB/util/query_sql.pl -d Gardnerella_vaginalis -f ../query_all.txt
echo Haemophilus_influenzae
perl ~/Scripts/alignDB/util/query_sql.pl -d Haemophilus_influenzae -f ../query_all.txt
echo Helicobacter_pylori
perl ~/Scripts/alignDB/util/query_sql.pl -d Helicobacter_pylori -f ../query_all.txt
echo Klebsiella_pneumoniae
perl ~/Scripts/alignDB/util/query_sql.pl -d Klebsiella_pneumoniae -f ../query_all.txt
echo Lactobacillus_acidophilus
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_acidophilus -f ../query_all.txt
echo Lactobacillus_casei
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_casei -f ../query_all.txt
echo Lactobacillus_delbrueckii
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_delbrueckii -f ../query_all.txt
echo Lactobacillus_fermentum
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_fermentum -f ../query_all.txt
echo Lactobacillus_helveticus
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_helveticus -f ../query_all.txt
echo Lactobacillus_johnsonii
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_johnsonii -f ../query_all.txt
echo Lactobacillus_plantarum
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_plantarum -f ../query_all.txt
echo Lactobacillus_reuteri
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_reuteri -f ../query_all.txt
echo Lactobacillus_rhamnosus
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactobacillus_rhamnosus -f ../query_all.txt
echo Lactococcus_lactis
perl ~/Scripts/alignDB/util/query_sql.pl -d Lactococcus_lactis -f ../query_all.txt
echo Legionella_pneumophila
perl ~/Scripts/alignDB/util/query_sql.pl -d Legionella_pneumophila -f ../query_all.txt
echo Leptospira_interrogans
perl ~/Scripts/alignDB/util/query_sql.pl -d Leptospira_interrogans -f ../query_all.txt
echo Listeria_monocytogenes
perl ~/Scripts/alignDB/util/query_sql.pl -d Listeria_monocytogenes -f ../query_all.txt
echo Mannheimia_haemolytica
perl ~/Scripts/alignDB/util/query_sql.pl -d Mannheimia_haemolytica -f ../query_all.txt
echo Methanococcus_maripaludis
perl ~/Scripts/alignDB/util/query_sql.pl -d Methanococcus_maripaludis -f ../query_all.txt
echo Methylobacterium_extorquens
perl ~/Scripts/alignDB/util/query_sql.pl -d Methylobacterium_extorquens -f ../query_all.txt
echo Mycobacterium_abscessus
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycobacterium_abscessus -f ../query_all.txt
echo Mycobacterium_avium
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycobacterium_avium -f ../query_all.txt
echo Mycobacterium_bovis
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycobacterium_bovis -f ../query_all.txt
echo Mycobacterium_canettii
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycobacterium_canettii -f ../query_all.txt
echo Mycobacterium_intracellulare
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycobacterium_intracellulare -f ../query_all.txt
echo Mycobacterium_tuberculosis
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycobacterium_tuberculosis -f ../query_all.txt
echo Mycoplasma_bovis
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycoplasma_bovis -f ../query_all.txt
echo Mycoplasma_fermentans
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycoplasma_fermentans -f ../query_all.txt
echo Mycoplasma_gallisepticum
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycoplasma_gallisepticum -f ../query_all.txt
echo Mycoplasma_genitalium
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycoplasma_genitalium -f ../query_all.txt
echo Mycoplasma_hyopneumoniae
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycoplasma_hyopneumoniae -f ../query_all.txt
echo Mycoplasma_hyorhinis
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycoplasma_hyorhinis -f ../query_all.txt
echo Mycoplasma_mycoides
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycoplasma_mycoides -f ../query_all.txt
echo Mycoplasma_pneumoniae
perl ~/Scripts/alignDB/util/query_sql.pl -d Mycoplasma_pneumoniae -f ../query_all.txt
echo Neisseria_gonorrhoeae
perl ~/Scripts/alignDB/util/query_sql.pl -d Neisseria_gonorrhoeae -f ../query_all.txt
echo Neisseria_meningitidis
perl ~/Scripts/alignDB/util/query_sql.pl -d Neisseria_meningitidis -f ../query_all.txt
echo Paenibacillus_mucilaginosus
perl ~/Scripts/alignDB/util/query_sql.pl -d Paenibacillus_mucilaginosus -f ../query_all.txt
echo Paenibacillus_polymyxa
perl ~/Scripts/alignDB/util/query_sql.pl -d Paenibacillus_polymyxa -f ../query_all.txt
echo Pantoea_ananatis
perl ~/Scripts/alignDB/util/query_sql.pl -d Pantoea_ananatis -f ../query_all.txt
echo Pasteurella_multocida
perl ~/Scripts/alignDB/util/query_sql.pl -d Pasteurella_multocida -f ../query_all.txt
echo Porphyromonas_gingivalis
perl ~/Scripts/alignDB/util/query_sql.pl -d Porphyromonas_gingivalis -f ../query_all.txt
echo Prochlorococcus_marinus
perl ~/Scripts/alignDB/util/query_sql.pl -d Prochlorococcus_marinus -f ../query_all.txt
echo Propionibacterium_acnes
perl ~/Scripts/alignDB/util/query_sql.pl -d Propionibacterium_acnes -f ../query_all.txt
echo Pseudomonas_aeruginosa
perl ~/Scripts/alignDB/util/query_sql.pl -d Pseudomonas_aeruginosa -f ../query_all.txt
echo Pseudomonas_fluorescens
perl ~/Scripts/alignDB/util/query_sql.pl -d Pseudomonas_fluorescens -f ../query_all.txt
echo Pseudomonas_putida
perl ~/Scripts/alignDB/util/query_sql.pl -d Pseudomonas_putida -f ../query_all.txt
echo Pseudomonas_stutzeri
perl ~/Scripts/alignDB/util/query_sql.pl -d Pseudomonas_stutzeri -f ../query_all.txt
echo Ralstonia_solanacearum
perl ~/Scripts/alignDB/util/query_sql.pl -d Ralstonia_solanacearum -f ../query_all.txt
echo Rhizobium_etli
perl ~/Scripts/alignDB/util/query_sql.pl -d Rhizobium_etli -f ../query_all.txt
echo Rhizobium_leguminosarum
perl ~/Scripts/alignDB/util/query_sql.pl -d Rhizobium_leguminosarum -f ../query_all.txt
echo Rhodobacter_sphaeroides
perl ~/Scripts/alignDB/util/query_sql.pl -d Rhodobacter_sphaeroides -f ../query_all.txt
echo Rhodopseudomonas_palustris
perl ~/Scripts/alignDB/util/query_sql.pl -d Rhodopseudomonas_palustris -f ../query_all.txt
echo Rickettsia_prowazekii
perl ~/Scripts/alignDB/util/query_sql.pl -d Rickettsia_prowazekii -f ../query_all.txt
echo Rickettsia_rickettsii
perl ~/Scripts/alignDB/util/query_sql.pl -d Rickettsia_rickettsii -f ../query_all.txt
echo Rickettsia_typhi
perl ~/Scripts/alignDB/util/query_sql.pl -d Rickettsia_typhi -f ../query_all.txt
echo Riemerella_anatipestifer
perl ~/Scripts/alignDB/util/query_sql.pl -d Riemerella_anatipestifer -f ../query_all.txt
echo Salmonella_enterica
perl ~/Scripts/alignDB/util/query_sql.pl -d Salmonella_enterica -f ../query_all.txt
echo Serratia_plymuthica
perl ~/Scripts/alignDB/util/query_sql.pl -d Serratia_plymuthica -f ../query_all.txt
echo Shewanella_baltica
perl ~/Scripts/alignDB/util/query_sql.pl -d Shewanella_baltica -f ../query_all.txt
echo Shigella_flexneri
perl ~/Scripts/alignDB/util/query_sql.pl -d Shigella_flexneri -f ../query_all.txt
echo Sinorhizobium_meliloti
perl ~/Scripts/alignDB/util/query_sql.pl -d Sinorhizobium_meliloti -f ../query_all.txt
echo Staphylococcus_aureus
perl ~/Scripts/alignDB/util/query_sql.pl -d Staphylococcus_aureus -f ../query_all.txt
echo Stenotrophomonas_maltophilia
perl ~/Scripts/alignDB/util/query_sql.pl -d Stenotrophomonas_maltophilia -f ../query_all.txt
echo Streptococcus_agalactiae
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_agalactiae -f ../query_all.txt
echo Streptococcus_constellatus
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_constellatus -f ../query_all.txt
echo Streptococcus_dysgalactiae
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_dysgalactiae -f ../query_all.txt
echo Streptococcus_equi
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_equi -f ../query_all.txt
echo Streptococcus_gallolyticus
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_gallolyticus -f ../query_all.txt
echo Streptococcus_intermedius
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_intermedius -f ../query_all.txt
echo Streptococcus_mutans
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_mutans -f ../query_all.txt
echo Streptococcus_pneumoniae
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_pneumoniae -f ../query_all.txt
echo Streptococcus_pyogenes
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_pyogenes -f ../query_all.txt
echo Streptococcus_salivarius
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_salivarius -f ../query_all.txt
echo Streptococcus_suis
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_suis -f ../query_all.txt
echo Streptococcus_thermophilus
perl ~/Scripts/alignDB/util/query_sql.pl -d Streptococcus_thermophilus -f ../query_all.txt
echo Sulfolobus_acidocaldarius
perl ~/Scripts/alignDB/util/query_sql.pl -d Sulfolobus_acidocaldarius -f ../query_all.txt
echo Sulfolobus_islandicus
perl ~/Scripts/alignDB/util/query_sql.pl -d Sulfolobus_islandicus -f ../query_all.txt
echo Thermus_thermophilus
perl ~/Scripts/alignDB/util/query_sql.pl -d Thermus_thermophilus -f ../query_all.txt
echo Treponema_pallidum
perl ~/Scripts/alignDB/util/query_sql.pl -d Treponema_pallidum -f ../query_all.txt
echo Variovorax_paradoxus
perl ~/Scripts/alignDB/util/query_sql.pl -d Variovorax_paradoxus -f ../query_all.txt
echo Vibrio_cholerae
perl ~/Scripts/alignDB/util/query_sql.pl -d Vibrio_cholerae -f ../query_all.txt
echo Vibrio_vulnificus
perl ~/Scripts/alignDB/util/query_sql.pl -d Vibrio_vulnificus -f ../query_all.txt
echo Xanthomonas_campestris
perl ~/Scripts/alignDB/util/query_sql.pl -d Xanthomonas_campestris -f ../query_all.txt
echo Xanthomonas_oryzae
perl ~/Scripts/alignDB/util/query_sql.pl -d Xanthomonas_oryzae -f ../query_all.txt
echo Xylella_fastidiosa
perl ~/Scripts/alignDB/util/query_sql.pl -d Xylella_fastidiosa -f ../query_all.txt
echo Yersinia_enterocolitica
perl ~/Scripts/alignDB/util/query_sql.pl -d Yersinia_enterocolitica -f ../query_all.txt
echo Yersinia_pestis
perl ~/Scripts/alignDB/util/query_sql.pl -d Yersinia_pestis -f ../query_all.txt
echo Yersinia_pseudotuberculosis
perl ~/Scripts/alignDB/util/query_sql.pl -d Yersinia_pseudotuberculosis -f ../query_all.txt
echo Zymomonas_mobilis
perl ~/Scripts/alignDB/util/query_sql.pl -d Zymomonas_mobilis -f ../query_all.txt

cd ~/data/gsw_logistic_regression

