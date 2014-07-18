@echo off
setlocal enabledelayedexpansion
SET lastfolder=0
SET dest=0
SET windest=0
SET src=0
SET winsrc=0
SET last=0

SET winsrc=%1
SET src=%winsrc:\=/%
SET src=/cygdrive/%src:~1,1%%src:~3,-1%

SET windest=%2
SET dest=%windest:\=/%
SET dest=/cygdrive/%dest:~1,1%%dest:~3,-2%

echo Src: %src% 
echo (win: %winsrc%)
echo Dest: %dest%
echo (win: %windest%)

SET last=%windest:~1,-1%
SET last=%last:~0,-1%
echo ohne letzten Slash: %last%
SET last=%last:\=;%
SET last=%last: =#%
echo bereinigter pfad: %last%

for /F "tokens=* delims=;" %%i IN ("%last%") DO call :LAST_FOLDER %%i
goto :EOF
:LAST_FOLDER
if "%1"=="" (
    SET lastfolder=%LAST:#= %
    goto :CONTINUE
)
SET LAST=%1
SHIFT
goto :LAST_FOLDER
:CONTINUE
echo lastfolder=%lastfolder%

SET searchpath=!windest:%lastfolder%=!
SET searchpath=%searchpath:~1,-3%

echo searchpath=%searchpath%

echo Nach letztem Ordner suchen in %searchpath%
FOR /F " tokens=*" %%i IN ('dir %searchpath% /b /ad-h /o-d') DO (
    SET lastfolder=%%i
    GOTO :FOUND
)
echo No subfolder found
::mkdir %windest%
::E:\Dorian\Desktop\rsync\rsync -avh --delete --ignore-existing --link-dest="%src" "%src%" "%dest%"
goto :eof
:FOUND
echo Letzter Sicherungsordner: 
echo %lastfolder%
SET lastfolder=%searchpath%/%lastfolder%
SET lastfolder=/cygdrive/%lastfolder:~0,1%/%lastfolder:~3%
SET lastfolder=%lastfolder:\=/%
echo %lastfolder%
echo Dateien kopieren...
echo mkdir %windest%
mkdir %windest%
echo rsync -avh --delete --ignore-existing --progress --link-dest="%lastfolder%" "%lastfolder%/" "%dest%"
rsync -avh --delete --ignore-existing --progress --link-dest="%lastfolder%" "%lastfolder%/" "%dest%"


::echo Warte 20 Sek...
::ping localhost -n 20 >NUL
:EOF
pause