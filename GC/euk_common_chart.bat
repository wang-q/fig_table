REM HumanvsCGOR
if not exist HumanvsCGOR.multi.xlsx goto skipHumanvsCGOR
perl d:/wq/Scripts/alignDB/stat/multi_chart_factory.pl --replace diversity=divergence -i HumanvsCGOR.multi.xlsx
:skipHumanvsCGOR

REM DmelvsXXII
if not exist DmelvsXXII.multi.xlsx goto skipDmelvsXXII
perl d:/wq/Scripts/alignDB/stat/multi_chart_factory.pl  -i DmelvsXXII.multi.xlsx
:skipDmelvsXXII

REM AthvsXIX
if not exist AthvsXIX.multi.xlsx goto skipAthvsXIX
perl d:/wq/Scripts/alignDB/stat/multi_chart_factory.pl  -i AthvsXIX.multi.xlsx
:skipAthvsXIX

REM S288CvsVIII_WGS
if not exist S288CvsVIII_WGS.multi.xlsx goto skipS288CvsVIII_WGS
perl d:/wq/Scripts/alignDB/stat/multi_chart_factory.pl  -i S288CvsVIII_WGS.multi.xlsx
:skipS288CvsVIII_WGS

REM HumanvsRhesus
if not exist HumanvsRhesus.common.xlsx goto skipHumanvsRhesus
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i HumanvsRhesus.common.xlsx
:skipHumanvsRhesus

REM HumanvsGibbon
if not exist HumanvsGibbon.common.xlsx goto skipHumanvsGibbon
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i HumanvsGibbon.common.xlsx
:skipHumanvsGibbon

REM MousevsXIIS
if not exist MousevsXIIS.multi.xlsx goto skipMousevsXIIS
perl d:/wq/Scripts/alignDB/stat/multi_chart_factory.pl  -i MousevsXIIS.multi.xlsx
:skipMousevsXIIS

REM MousevsSpretus_Ei
if not exist MousevsSpretus_Ei.common.xlsx goto skipMousevsSpretus_Ei
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i MousevsSpretus_Ei.common.xlsx
:skipMousevsSpretus_Ei

REM DsimvsDsec
if not exist DsimvsDsec.common.xlsx goto skipDsimvsDsec
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i DsimvsDsec.common.xlsx
:skipDsimvsDsec

REM DyakvsDere
if not exist DyakvsDere.common.xlsx goto skipDyakvsDere
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i DyakvsDere.common.xlsx
:skipDyakvsDere

REM NipvsXXIV
if not exist NipvsXXIV.multi.xlsx goto skipNipvsXXIV
perl d:/wq/Scripts/alignDB/stat/multi_chart_factory.pl  -i NipvsXXIV.multi.xlsx
:skipNipvsXXIV

REM Nipvs9311
if not exist Nipvs9311.common.xlsx goto skipNipvs9311
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl  -i Nipvs9311.common.xlsx
:skipNipvs9311

REM AthvsLyrata
if not exist AthvsLyrata.common.xlsx goto skipAthvsLyrata
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i AthvsLyrata.common.xlsx
:skipAthvsLyrata

REM S288CvsSpar
if not exist S288CvsSpar.common.xlsx goto skipS288CvsSpar
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i S288CvsSpar.common.xlsx
:skipS288CvsSpar

REM AfumvsNfis
if not exist AfumvsNfis.common.xlsx goto skipAfumvsNfis
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i AfumvsNfis.common.xlsx
:skipAfumvsNfis

REM AoryvsAfla
if not exist AoryvsAfla.common.xlsx goto skipAoryvsAfla
perl d:/wq/Scripts/alignDB/stat/common_chart_factory.pl --replace diversity=divergence -i AoryvsAfla.common.xlsx
:skipAoryvsAfla

