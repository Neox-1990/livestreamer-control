@echo off
COLOR 0A
:step1
set /p ADRESSE=Adresse eingeben:
call livestreamer.exe %ADRESSE%
:step2
set /p QUALI=Qualitaet eingeben:
:step3
call livestreamer.exe %ADRESSE% %QUALI%
echo [1] Stream Neustarten
echo [2] Qualitaet aendern
echo [3] Neuen Quelle
echo [4] Beenden
set /p INPUT=
IF "%INPUT%" == "1" GOTO :step3
IF "%INPUT%" == "2" GOTO :step2
IF "%INPUT%" == "3" GOTO :step1