REM HumanvsCGOR
if not exist HumanvsCGOR.gene.xlsx goto skipHumanvsCGOR
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i HumanvsCGOR.gene.xlsx
:skipHumanvsCGOR

REM DmelvsXXII
if not exist DmelvsXXII.gene.xlsx goto skipDmelvsXXII
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl  -i DmelvsXXII.gene.xlsx
:skipDmelvsXXII

REM AthvsXIX
if not exist AthvsXIX.gene.xlsx goto skipAthvsXIX
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl  -i AthvsXIX.gene.xlsx
:skipAthvsXIX

REM S288CvsVIII_WGS
if not exist S288CvsVIII_WGS.gene.xlsx goto skipS288CvsVIII_WGS
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl  -i S288CvsVIII_WGS.gene.xlsx
:skipS288CvsVIII_WGS

REM HumanvsRhesus
if not exist HumanvsRhesus.gene.xlsx goto skipHumanvsRhesus
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i HumanvsRhesus.gene.xlsx
:skipHumanvsRhesus

REM HumanvsGibbon
if not exist HumanvsGibbon.gene.xlsx goto skipHumanvsGibbon
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i HumanvsGibbon.gene.xlsx
:skipHumanvsGibbon

REM MousevsXIIS
if not exist MousevsXIIS.gene.xlsx goto skipMousevsXIIS
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl  -i MousevsXIIS.gene.xlsx
:skipMousevsXIIS

REM MousevsSpretus_Ei
if not exist MousevsSpretus_Ei.gene.xlsx goto skipMousevsSpretus_Ei
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i MousevsSpretus_Ei.gene.xlsx
:skipMousevsSpretus_Ei

REM DsimvsDsec
if not exist DsimvsDsec.gene.xlsx goto skipDsimvsDsec
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i DsimvsDsec.gene.xlsx
:skipDsimvsDsec

REM DyakvsDere
if not exist DyakvsDere.gene.xlsx goto skipDyakvsDere
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i DyakvsDere.gene.xlsx
:skipDyakvsDere

REM NipvsXXIV
if not exist NipvsXXIV.gene.xlsx goto skipNipvsXXIV
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl  -i NipvsXXIV.gene.xlsx
:skipNipvsXXIV

REM Nipvs9311
if not exist Nipvs9311.gene.xlsx goto skipNipvs9311
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl  -i Nipvs9311.gene.xlsx
:skipNipvs9311

REM AthvsLyrata
if not exist AthvsLyrata.gene.xlsx goto skipAthvsLyrata
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i AthvsLyrata.gene.xlsx
:skipAthvsLyrata

REM S288CvsSpar
if not exist S288CvsSpar.gene.xlsx goto skipS288CvsSpar
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i S288CvsSpar.gene.xlsx
:skipS288CvsSpar

REM AfumvsNfis
if not exist AfumvsNfis.gene.xlsx goto skipAfumvsNfis
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i AfumvsNfis.gene.xlsx
:skipAfumvsNfis

REM AoryvsAfla
if not exist AoryvsAfla.gene.xlsx goto skipAoryvsAfla
perl d:/wq/Scripts/alignDB/stat/gene_chart_factory.pl --replace diversity=divergence -i AoryvsAfla.gene.xlsx
:skipAoryvsAfla

