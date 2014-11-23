REM HumanvsCGOR
if not exist HumanvsCGOR.gc.xlsx goto skipHumanvsCGOR
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i HumanvsCGOR.gc.xlsx
:skipHumanvsCGOR

REM DmelvsXXII
if not exist DmelvsXXII.gc.xlsx goto skipDmelvsXXII
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl  -i DmelvsXXII.gc.xlsx
:skipDmelvsXXII

REM AthvsXIX
if not exist AthvsXIX.gc.xlsx goto skipAthvsXIX
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl  -i AthvsXIX.gc.xlsx
:skipAthvsXIX

REM S288CvsVIII_WGS
if not exist S288CvsVIII_WGS.gc.xlsx goto skipS288CvsVIII_WGS
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl  -i S288CvsVIII_WGS.gc.xlsx
:skipS288CvsVIII_WGS

REM HumanvsRhesus
if not exist HumanvsRhesus.gc.xlsx goto skipHumanvsRhesus
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i HumanvsRhesus.gc.xlsx
:skipHumanvsRhesus

REM HumanvsGibbon
if not exist HumanvsGibbon.gc.xlsx goto skipHumanvsGibbon
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i HumanvsGibbon.gc.xlsx
:skipHumanvsGibbon

REM MousevsXIIS
if not exist MousevsXIIS.gc.xlsx goto skipMousevsXIIS
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl  -i MousevsXIIS.gc.xlsx
:skipMousevsXIIS

REM MousevsSpretus_Ei
if not exist MousevsSpretus_Ei.gc.xlsx goto skipMousevsSpretus_Ei
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i MousevsSpretus_Ei.gc.xlsx
:skipMousevsSpretus_Ei

REM DsimvsDsec
if not exist DsimvsDsec.gc.xlsx goto skipDsimvsDsec
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i DsimvsDsec.gc.xlsx
:skipDsimvsDsec

REM DyakvsDere
if not exist DyakvsDere.gc.xlsx goto skipDyakvsDere
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i DyakvsDere.gc.xlsx
:skipDyakvsDere

REM NipvsXXIV
if not exist NipvsXXIV.gc.xlsx goto skipNipvsXXIV
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl  -i NipvsXXIV.gc.xlsx
:skipNipvsXXIV

REM Nipvs9311
if not exist Nipvs9311.gc.xlsx goto skipNipvs9311
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl  -i Nipvs9311.gc.xlsx
:skipNipvs9311

REM AthvsLyrata
if not exist AthvsLyrata.gc.xlsx goto skipAthvsLyrata
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i AthvsLyrata.gc.xlsx
:skipAthvsLyrata

REM S288CvsSpar
if not exist S288CvsSpar.gc.xlsx goto skipS288CvsSpar
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i S288CvsSpar.gc.xlsx
:skipS288CvsSpar

REM AfumvsNfis
if not exist AfumvsNfis.gc.xlsx goto skipAfumvsNfis
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i AfumvsNfis.gc.xlsx
:skipAfumvsNfis

REM AoryvsAfla
if not exist AoryvsAfla.gc.xlsx goto skipAoryvsAfla
perl d:/wq/Scripts/alignDB/stat/gc_chart_factory.pl --replace diversity=divergence -i AoryvsAfla.gc.xlsx
:skipAoryvsAfla

