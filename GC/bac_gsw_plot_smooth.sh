cd ~/data/gsw_logistic_regression

if [ -d bac_gr_fig ]
then
    rm -fr bac_gr_fig
fi

mkdir bac_gr_fig
cd bac_gr_fig

echo Acetobacter_pasteurianus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Acetobacter_pasteurianus.csv -t Acetobacter_pasteurianus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Acetobacter_pasteurianus.csv -t Acetobacter_pasteurianus --label -d pdf -x window_cv -y flag
echo Acinetobacter_baumannii
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Acinetobacter_baumannii.csv -t Acinetobacter_baumannii --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Acinetobacter_baumannii.csv -t Acinetobacter_baumannii --label -d pdf -x window_cv -y flag
echo Actinobacillus_pleuropneumoniae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Actinobacillus_pleuropneumoniae.csv -t Actinobacillus_pleuropneumoniae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Actinobacillus_pleuropneumoniae.csv -t Actinobacillus_pleuropneumoniae --label -d pdf -x window_cv -y flag
echo Aggregatibacter_actinomycetemcomitans
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Aggregatibacter_actinomycetemcomitans.csv -t Aggregatibacter_actinomycetemcomitans --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Aggregatibacter_actinomycetemcomitans.csv -t Aggregatibacter_actinomycetemcomitans --label -d pdf -x window_cv -y flag
echo Alteromonas_macleodii
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Alteromonas_macleodii.csv -t Alteromonas_macleodii --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Alteromonas_macleodii.csv -t Alteromonas_macleodii --label -d pdf -x window_cv -y flag
echo Arcobacter_butzleri
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Arcobacter_butzleri.csv -t Arcobacter_butzleri --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Arcobacter_butzleri.csv -t Arcobacter_butzleri --label -d pdf -x window_cv -y flag
echo Bacillus_amyloliquefaciens
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacillus_amyloliquefaciens.csv -t Bacillus_amyloliquefaciens --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacillus_amyloliquefaciens.csv -t Bacillus_amyloliquefaciens --label -d pdf -x window_cv -y flag
echo Bacillus_cereus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacillus_cereus.csv -t Bacillus_cereus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacillus_cereus.csv -t Bacillus_cereus --label -d pdf -x window_cv -y flag
echo Bacillus_subtilis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacillus_subtilis.csv -t Bacillus_subtilis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacillus_subtilis.csv -t Bacillus_subtilis --label -d pdf -x window_cv -y flag
echo Bacillus_thuringiensis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacillus_thuringiensis.csv -t Bacillus_thuringiensis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacillus_thuringiensis.csv -t Bacillus_thuringiensis --label -d pdf -x window_cv -y flag
echo Bacteroides_fragilis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacteroides_fragilis.csv -t Bacteroides_fragilis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bacteroides_fragilis.csv -t Bacteroides_fragilis --label -d pdf -x window_cv -y flag
echo Bifidobacterium_animalis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bifidobacterium_animalis.csv -t Bifidobacterium_animalis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bifidobacterium_animalis.csv -t Bifidobacterium_animalis --label -d pdf -x window_cv -y flag
echo Bifidobacterium_bifidum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bifidobacterium_bifidum.csv -t Bifidobacterium_bifidum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bifidobacterium_bifidum.csv -t Bifidobacterium_bifidum --label -d pdf -x window_cv -y flag
echo Bifidobacterium_longum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bifidobacterium_longum.csv -t Bifidobacterium_longum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Bifidobacterium_longum.csv -t Bifidobacterium_longum --label -d pdf -x window_cv -y flag
echo Borrelia_burgdorferi
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Borrelia_burgdorferi.csv -t Borrelia_burgdorferi --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Borrelia_burgdorferi.csv -t Borrelia_burgdorferi --label -d pdf -x window_cv -y flag
echo Burkholderia_cenocepacia
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Burkholderia_cenocepacia.csv -t Burkholderia_cenocepacia --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Burkholderia_cenocepacia.csv -t Burkholderia_cenocepacia --label -d pdf -x window_cv -y flag
echo Campylobacter_jejuni
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Campylobacter_jejuni.csv -t Campylobacter_jejuni --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Campylobacter_jejuni.csv -t Campylobacter_jejuni --label -d pdf -x window_cv -y flag
echo Chlamydia_pneumoniae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Chlamydia_pneumoniae.csv -t Chlamydia_pneumoniae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Chlamydia_pneumoniae.csv -t Chlamydia_pneumoniae --label -d pdf -x window_cv -y flag
echo Chlamydia_psittaci
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Chlamydia_psittaci.csv -t Chlamydia_psittaci --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Chlamydia_psittaci.csv -t Chlamydia_psittaci --label -d pdf -x window_cv -y flag
echo Chlamydia_trachomatis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Chlamydia_trachomatis.csv -t Chlamydia_trachomatis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Chlamydia_trachomatis.csv -t Chlamydia_trachomatis --label -d pdf -x window_cv -y flag
echo Clostridium_botulinum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Clostridium_botulinum.csv -t Clostridium_botulinum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Clostridium_botulinum.csv -t Clostridium_botulinum --label -d pdf -x window_cv -y flag
echo Clostridium_perfringens
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Clostridium_perfringens.csv -t Clostridium_perfringens --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Clostridium_perfringens.csv -t Clostridium_perfringens --label -d pdf -x window_cv -y flag
echo Corynebacterium_diphtheriae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Corynebacterium_diphtheriae.csv -t Corynebacterium_diphtheriae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Corynebacterium_diphtheriae.csv -t Corynebacterium_diphtheriae --label -d pdf -x window_cv -y flag
echo Corynebacterium_glutamicum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Corynebacterium_glutamicum.csv -t Corynebacterium_glutamicum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Corynebacterium_glutamicum.csv -t Corynebacterium_glutamicum --label -d pdf -x window_cv -y flag
echo Corynebacterium_pseudotuberculosis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Corynebacterium_pseudotuberculosis.csv -t Corynebacterium_pseudotuberculosis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Corynebacterium_pseudotuberculosis.csv -t Corynebacterium_pseudotuberculosis --label -d pdf -x window_cv -y flag
echo Corynebacterium_ulcerans
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Corynebacterium_ulcerans.csv -t Corynebacterium_ulcerans --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Corynebacterium_ulcerans.csv -t Corynebacterium_ulcerans --label -d pdf -x window_cv -y flag
echo Coxiella_burnetii
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Coxiella_burnetii.csv -t Coxiella_burnetii --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Coxiella_burnetii.csv -t Coxiella_burnetii --label -d pdf -x window_cv -y flag
echo Cronobacter_sakazakii
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Cronobacter_sakazakii.csv -t Cronobacter_sakazakii --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Cronobacter_sakazakii.csv -t Cronobacter_sakazakii --label -d pdf -x window_cv -y flag
echo Dehalococcoides_mccartyi
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Dehalococcoides_mccartyi.csv -t Dehalococcoides_mccartyi --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Dehalococcoides_mccartyi.csv -t Dehalococcoides_mccartyi --label -d pdf -x window_cv -y flag
echo Desulfovibrio_vulgaris
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Desulfovibrio_vulgaris.csv -t Desulfovibrio_vulgaris --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Desulfovibrio_vulgaris.csv -t Desulfovibrio_vulgaris --label -d pdf -x window_cv -y flag
echo Dickeya_dadantii
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Dickeya_dadantii.csv -t Dickeya_dadantii --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Dickeya_dadantii.csv -t Dickeya_dadantii --label -d pdf -x window_cv -y flag
echo Edwardsiella_tarda
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Edwardsiella_tarda.csv -t Edwardsiella_tarda --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Edwardsiella_tarda.csv -t Edwardsiella_tarda --label -d pdf -x window_cv -y flag
echo Enterobacter_cloacae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Enterobacter_cloacae.csv -t Enterobacter_cloacae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Enterobacter_cloacae.csv -t Enterobacter_cloacae --label -d pdf -x window_cv -y flag
echo Enterococcus_faecalis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Enterococcus_faecalis.csv -t Enterococcus_faecalis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Enterococcus_faecalis.csv -t Enterococcus_faecalis --label -d pdf -x window_cv -y flag
echo Enterococcus_faecium
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Enterococcus_faecium.csv -t Enterococcus_faecium --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Enterococcus_faecium.csv -t Enterococcus_faecium --label -d pdf -x window_cv -y flag
echo Escherichia_coli
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Escherichia_coli.csv -t Escherichia_coli --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Escherichia_coli.csv -t Escherichia_coli --label -d pdf -x window_cv -y flag
echo Francisella_novicida
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Francisella_novicida.csv -t Francisella_novicida --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Francisella_novicida.csv -t Francisella_novicida --label -d pdf -x window_cv -y flag
echo Francisella_tularensis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Francisella_tularensis.csv -t Francisella_tularensis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Francisella_tularensis.csv -t Francisella_tularensis --label -d pdf -x window_cv -y flag
echo Gardnerella_vaginalis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Gardnerella_vaginalis.csv -t Gardnerella_vaginalis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Gardnerella_vaginalis.csv -t Gardnerella_vaginalis --label -d pdf -x window_cv -y flag
echo Haemophilus_influenzae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Haemophilus_influenzae.csv -t Haemophilus_influenzae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Haemophilus_influenzae.csv -t Haemophilus_influenzae --label -d pdf -x window_cv -y flag
echo Helicobacter_pylori
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Helicobacter_pylori.csv -t Helicobacter_pylori --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Helicobacter_pylori.csv -t Helicobacter_pylori --label -d pdf -x window_cv -y flag
echo Klebsiella_pneumoniae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Klebsiella_pneumoniae.csv -t Klebsiella_pneumoniae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Klebsiella_pneumoniae.csv -t Klebsiella_pneumoniae --label -d pdf -x window_cv -y flag
echo Lactobacillus_acidophilus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_acidophilus.csv -t Lactobacillus_acidophilus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_acidophilus.csv -t Lactobacillus_acidophilus --label -d pdf -x window_cv -y flag
echo Lactobacillus_casei
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_casei.csv -t Lactobacillus_casei --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_casei.csv -t Lactobacillus_casei --label -d pdf -x window_cv -y flag
echo Lactobacillus_delbrueckii
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_delbrueckii.csv -t Lactobacillus_delbrueckii --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_delbrueckii.csv -t Lactobacillus_delbrueckii --label -d pdf -x window_cv -y flag
echo Lactobacillus_fermentum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_fermentum.csv -t Lactobacillus_fermentum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_fermentum.csv -t Lactobacillus_fermentum --label -d pdf -x window_cv -y flag
echo Lactobacillus_helveticus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_helveticus.csv -t Lactobacillus_helveticus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_helveticus.csv -t Lactobacillus_helveticus --label -d pdf -x window_cv -y flag
echo Lactobacillus_johnsonii
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_johnsonii.csv -t Lactobacillus_johnsonii --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_johnsonii.csv -t Lactobacillus_johnsonii --label -d pdf -x window_cv -y flag
echo Lactobacillus_plantarum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_plantarum.csv -t Lactobacillus_plantarum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_plantarum.csv -t Lactobacillus_plantarum --label -d pdf -x window_cv -y flag
echo Lactobacillus_reuteri
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_reuteri.csv -t Lactobacillus_reuteri --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_reuteri.csv -t Lactobacillus_reuteri --label -d pdf -x window_cv -y flag
echo Lactobacillus_rhamnosus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_rhamnosus.csv -t Lactobacillus_rhamnosus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactobacillus_rhamnosus.csv -t Lactobacillus_rhamnosus --label -d pdf -x window_cv -y flag
echo Lactococcus_lactis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactococcus_lactis.csv -t Lactococcus_lactis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Lactococcus_lactis.csv -t Lactococcus_lactis --label -d pdf -x window_cv -y flag
echo Legionella_pneumophila
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Legionella_pneumophila.csv -t Legionella_pneumophila --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Legionella_pneumophila.csv -t Legionella_pneumophila --label -d pdf -x window_cv -y flag
echo Leptospira_interrogans
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Leptospira_interrogans.csv -t Leptospira_interrogans --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Leptospira_interrogans.csv -t Leptospira_interrogans --label -d pdf -x window_cv -y flag
echo Listeria_monocytogenes
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Listeria_monocytogenes.csv -t Listeria_monocytogenes --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Listeria_monocytogenes.csv -t Listeria_monocytogenes --label -d pdf -x window_cv -y flag
echo Methanococcus_maripaludis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Methanococcus_maripaludis.csv -t Methanococcus_maripaludis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Methanococcus_maripaludis.csv -t Methanococcus_maripaludis --label -d pdf -x window_cv -y flag
echo Mycobacterium_abscessus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycobacterium_abscessus.csv -t Mycobacterium_abscessus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycobacterium_abscessus.csv -t Mycobacterium_abscessus --label -d pdf -x window_cv -y flag
echo Mycobacterium_canettii
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycobacterium_canettii.csv -t Mycobacterium_canettii --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycobacterium_canettii.csv -t Mycobacterium_canettii --label -d pdf -x window_cv -y flag
echo Mycobacterium_intracellulare
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycobacterium_intracellulare.csv -t Mycobacterium_intracellulare --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycobacterium_intracellulare.csv -t Mycobacterium_intracellulare --label -d pdf -x window_cv -y flag
echo Mycoplasma_bovis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycoplasma_bovis.csv -t Mycoplasma_bovis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycoplasma_bovis.csv -t Mycoplasma_bovis --label -d pdf -x window_cv -y flag
echo Mycoplasma_gallisepticum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycoplasma_gallisepticum.csv -t Mycoplasma_gallisepticum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycoplasma_gallisepticum.csv -t Mycoplasma_gallisepticum --label -d pdf -x window_cv -y flag
echo Mycoplasma_hyopneumoniae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycoplasma_hyopneumoniae.csv -t Mycoplasma_hyopneumoniae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Mycoplasma_hyopneumoniae.csv -t Mycoplasma_hyopneumoniae --label -d pdf -x window_cv -y flag
echo Neisseria_gonorrhoeae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Neisseria_gonorrhoeae.csv -t Neisseria_gonorrhoeae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Neisseria_gonorrhoeae.csv -t Neisseria_gonorrhoeae --label -d pdf -x window_cv -y flag
echo Neisseria_meningitidis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Neisseria_meningitidis.csv -t Neisseria_meningitidis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Neisseria_meningitidis.csv -t Neisseria_meningitidis --label -d pdf -x window_cv -y flag
echo Paenibacillus_mucilaginosus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Paenibacillus_mucilaginosus.csv -t Paenibacillus_mucilaginosus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Paenibacillus_mucilaginosus.csv -t Paenibacillus_mucilaginosus --label -d pdf -x window_cv -y flag
echo Paenibacillus_polymyxa
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Paenibacillus_polymyxa.csv -t Paenibacillus_polymyxa --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Paenibacillus_polymyxa.csv -t Paenibacillus_polymyxa --label -d pdf -x window_cv -y flag
echo Pantoea_ananatis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pantoea_ananatis.csv -t Pantoea_ananatis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pantoea_ananatis.csv -t Pantoea_ananatis --label -d pdf -x window_cv -y flag
echo Pasteurella_multocida
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pasteurella_multocida.csv -t Pasteurella_multocida --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pasteurella_multocida.csv -t Pasteurella_multocida --label -d pdf -x window_cv -y flag
echo Porphyromonas_gingivalis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Porphyromonas_gingivalis.csv -t Porphyromonas_gingivalis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Porphyromonas_gingivalis.csv -t Porphyromonas_gingivalis --label -d pdf -x window_cv -y flag
echo Prochlorococcus_marinus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Prochlorococcus_marinus.csv -t Prochlorococcus_marinus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Prochlorococcus_marinus.csv -t Prochlorococcus_marinus --label -d pdf -x window_cv -y flag
echo Propionibacterium_acnes
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Propionibacterium_acnes.csv -t Propionibacterium_acnes --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Propionibacterium_acnes.csv -t Propionibacterium_acnes --label -d pdf -x window_cv -y flag
echo Pseudomonas_aeruginosa
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pseudomonas_aeruginosa.csv -t Pseudomonas_aeruginosa --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pseudomonas_aeruginosa.csv -t Pseudomonas_aeruginosa --label -d pdf -x window_cv -y flag
echo Pseudomonas_fluorescens
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pseudomonas_fluorescens.csv -t Pseudomonas_fluorescens --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pseudomonas_fluorescens.csv -t Pseudomonas_fluorescens --label -d pdf -x window_cv -y flag
echo Pseudomonas_putida
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pseudomonas_putida.csv -t Pseudomonas_putida --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pseudomonas_putida.csv -t Pseudomonas_putida --label -d pdf -x window_cv -y flag
echo Pseudomonas_stutzeri
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pseudomonas_stutzeri.csv -t Pseudomonas_stutzeri --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Pseudomonas_stutzeri.csv -t Pseudomonas_stutzeri --label -d pdf -x window_cv -y flag
echo Ralstonia_solanacearum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Ralstonia_solanacearum.csv -t Ralstonia_solanacearum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Ralstonia_solanacearum.csv -t Ralstonia_solanacearum --label -d pdf -x window_cv -y flag
echo Rhizobium_etli
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Rhizobium_etli.csv -t Rhizobium_etli --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Rhizobium_etli.csv -t Rhizobium_etli --label -d pdf -x window_cv -y flag
echo Rhizobium_leguminosarum
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Rhizobium_leguminosarum.csv -t Rhizobium_leguminosarum --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Rhizobium_leguminosarum.csv -t Rhizobium_leguminosarum --label -d pdf -x window_cv -y flag
echo Rhodopseudomonas_palustris
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Rhodopseudomonas_palustris.csv -t Rhodopseudomonas_palustris --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Rhodopseudomonas_palustris.csv -t Rhodopseudomonas_palustris --label -d pdf -x window_cv -y flag
echo Riemerella_anatipestifer
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Riemerella_anatipestifer.csv -t Riemerella_anatipestifer --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Riemerella_anatipestifer.csv -t Riemerella_anatipestifer --label -d pdf -x window_cv -y flag
echo Salmonella_enterica
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Salmonella_enterica.csv -t Salmonella_enterica --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Salmonella_enterica.csv -t Salmonella_enterica --label -d pdf -x window_cv -y flag
echo Serratia_plymuthica
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Serratia_plymuthica.csv -t Serratia_plymuthica --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Serratia_plymuthica.csv -t Serratia_plymuthica --label -d pdf -x window_cv -y flag
echo Shewanella_baltica
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Shewanella_baltica.csv -t Shewanella_baltica --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Shewanella_baltica.csv -t Shewanella_baltica --label -d pdf -x window_cv -y flag
echo Sinorhizobium_meliloti
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Sinorhizobium_meliloti.csv -t Sinorhizobium_meliloti --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Sinorhizobium_meliloti.csv -t Sinorhizobium_meliloti --label -d pdf -x window_cv -y flag
echo Staphylococcus_aureus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Staphylococcus_aureus.csv -t Staphylococcus_aureus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Staphylococcus_aureus.csv -t Staphylococcus_aureus --label -d pdf -x window_cv -y flag
echo Stenotrophomonas_maltophilia
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Stenotrophomonas_maltophilia.csv -t Stenotrophomonas_maltophilia --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Stenotrophomonas_maltophilia.csv -t Stenotrophomonas_maltophilia --label -d pdf -x window_cv -y flag
echo Streptococcus_agalactiae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_agalactiae.csv -t Streptococcus_agalactiae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_agalactiae.csv -t Streptococcus_agalactiae --label -d pdf -x window_cv -y flag
echo Streptococcus_dysgalactiae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_dysgalactiae.csv -t Streptococcus_dysgalactiae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_dysgalactiae.csv -t Streptococcus_dysgalactiae --label -d pdf -x window_cv -y flag
echo Streptococcus_equi
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_equi.csv -t Streptococcus_equi --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_equi.csv -t Streptococcus_equi --label -d pdf -x window_cv -y flag
echo Streptococcus_gallolyticus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_gallolyticus.csv -t Streptococcus_gallolyticus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_gallolyticus.csv -t Streptococcus_gallolyticus --label -d pdf -x window_cv -y flag
echo Streptococcus_intermedius
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_intermedius.csv -t Streptococcus_intermedius --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_intermedius.csv -t Streptococcus_intermedius --label -d pdf -x window_cv -y flag
echo Streptococcus_mutans
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_mutans.csv -t Streptococcus_mutans --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_mutans.csv -t Streptococcus_mutans --label -d pdf -x window_cv -y flag
echo Streptococcus_pneumoniae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_pneumoniae.csv -t Streptococcus_pneumoniae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_pneumoniae.csv -t Streptococcus_pneumoniae --label -d pdf -x window_cv -y flag
echo Streptococcus_pyogenes
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_pyogenes.csv -t Streptococcus_pyogenes --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_pyogenes.csv -t Streptococcus_pyogenes --label -d pdf -x window_cv -y flag
echo Streptococcus_salivarius
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_salivarius.csv -t Streptococcus_salivarius --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_salivarius.csv -t Streptococcus_salivarius --label -d pdf -x window_cv -y flag
echo Streptococcus_suis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_suis.csv -t Streptococcus_suis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_suis.csv -t Streptococcus_suis --label -d pdf -x window_cv -y flag
echo Streptococcus_thermophilus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_thermophilus.csv -t Streptococcus_thermophilus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Streptococcus_thermophilus.csv -t Streptococcus_thermophilus --label -d pdf -x window_cv -y flag
echo Sulfolobus_islandicus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Sulfolobus_islandicus.csv -t Sulfolobus_islandicus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Sulfolobus_islandicus.csv -t Sulfolobus_islandicus --label -d pdf -x window_cv -y flag
echo Variovorax_paradoxus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Variovorax_paradoxus.csv -t Variovorax_paradoxus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Variovorax_paradoxus.csv -t Variovorax_paradoxus --label -d pdf -x window_cv -y flag
echo Vibrio_cholerae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Vibrio_cholerae.csv -t Vibrio_cholerae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Vibrio_cholerae.csv -t Vibrio_cholerae --label -d pdf -x window_cv -y flag
echo Vibrio_vulnificus
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Vibrio_vulnificus.csv -t Vibrio_vulnificus --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Vibrio_vulnificus.csv -t Vibrio_vulnificus --label -d pdf -x window_cv -y flag
echo Xanthomonas_campestris
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Xanthomonas_campestris.csv -t Xanthomonas_campestris --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Xanthomonas_campestris.csv -t Xanthomonas_campestris --label -d pdf -x window_cv -y flag
echo Xanthomonas_oryzae
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Xanthomonas_oryzae.csv -t Xanthomonas_oryzae --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Xanthomonas_oryzae.csv -t Xanthomonas_oryzae --label -d pdf -x window_cv -y flag
echo Xylella_fastidiosa
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Xylella_fastidiosa.csv -t Xylella_fastidiosa --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Xylella_fastidiosa.csv -t Xylella_fastidiosa --label -d pdf -x window_cv -y flag
echo Yersinia_enterocolitica
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Yersinia_enterocolitica.csv -t Yersinia_enterocolitica --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Yersinia_enterocolitica.csv -t Yersinia_enterocolitica --label -d pdf -x window_cv -y flag
echo Yersinia_pseudotuberculosis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Yersinia_pseudotuberculosis.csv -t Yersinia_pseudotuberculosis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Yersinia_pseudotuberculosis.csv -t Yersinia_pseudotuberculosis --label -d pdf -x window_cv -y flag
echo Zymomonas_mobilis
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Zymomonas_mobilis.csv -t Zymomonas_mobilis --label -d pdf -x window_gc -y flag
perl ~/Scripts/alignDB/fig/plot_smooth.pl -f ../bac_gr/Zymomonas_mobilis.csv -t Zymomonas_mobilis --label -d pdf -x window_cv -y flag

cd ~/data/gsw_logistic_regression

