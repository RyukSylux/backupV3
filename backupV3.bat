@echo off
CHCP 1252
rem source https://initscreen.developpez.com/tutoriels/batch/apprendre-la-programmation-de-script-batch/#LIV-L
set "ScriptName=%~nx0"
setlocal
:ParseArgs
if "%~1"=="" goto Init
if /i "%~1"=="/?" goto Help
if /i "%~1"=="-?" goto Help
if /i "%~1"=="/h" goto Help
if /i "%~1"=="-h" goto Help
if /i "%~1"=="/help" goto Help
if /i "%~1"=="-help" goto Help
if /i "%~1"=="/o" (
    set "outprout=%~2"
    set /a "outprout"
    if errorlevel 1 (
        shift /1
        goto BadSyntax
    )
    shift /1
    shift /1
    goto ParseArgs
)
if /i "%~1"=="/O" (
    set "outprout=%~2"
    set /a "outprout"
    if errorlevel 1 (
        shift /1
        goto BadSyntax
    )
    shift /1
    shift /1
    goto ParseArgs
)
if /i "%~1"=="-o" (
    set "outprout=%~2"
    set /a "outprout"
    if errorlevel 1 (
        shift /1
        goto BadSyntax
    )
    shift /1
    shift /1
    goto ParseArgs
)
if /i "%~1"=="-O" (
    set "outprout=%~2"
    set /a "outprout"
    if errorlevel 1 (
        shift /1
        goto BadSyntax
    )
    shift /1
    shift /1
    goto ParseArgs
)
if /i "%~1"=="/i" (
    set "inprout=%~2"
    set /a "inprout"
    if errorlevel 1 (
        shift /1
        goto BadSyntax
    )
    shift /1
    shift /1
    goto ParseArgs
)
if /i "%~1"=="-i" (
    set "inprout=%~2"
    set /a "inprout"
    if errorlevel 1 (
        shift /1
        goto BadSyntax
    )
    shift /1
    shift /1
    goto ParseArgs
)
if /i "%~1"=="/I" (
    set "inprout=%~2"
    set /a "inprout"
    if errorlevel 1 (
        shift /1
        goto BadSyntax
    )
    shift /1
    shift /1
    goto ParseArgs
)
if /i "%~1"=="-I" (
    set "inprout=%~2"
    set /a "inprout"
    if errorlevel 1 (
        shift /1
        goto BadSyntax
    )
    shift /1
    shift /1
    goto ParseArgs
)

:BadSyntax
echo.
rem La commande 'net helpmsg' affiche un message prédéfini dans
rem la langue d'installation du système d'exploitation
net helpmsg 87
echo [ %~1 ]
echo.
if not "%~0"==":BadSyntax" endlocal
exit /b 1

:Init
if defined outprout if defined inprout goto Exec

:UnknowError
call :BadSyntax /o
call :Help
endlocal
exit /b 2

:Exec
REM FAIS MAISON PAR DURIR
cd /d "%outprout%"
For /F %%$ In ('dir/B/O:d *.zip')Do (
	Set Dossier=%%$
	Goto:SORTIE
)
:SORTIE
echo %outprout%\%Dossier%
cd /d %inprout%
tar -zcvf "%outprout%\ajour_backup_%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.zip" Interface WTF
echo erreur lvl %errorlevel%
REM if %errorlevel% ==0 (start "" "%USERPROFILE%\AppData\Local\Programs\wowup-cf\WowUp-CF.exe" & exit) else (echo le backup s est mal passe & goto UnknowError)

goto End

:Help
echo.
echo %ScriptName% [-o|-O/o^|/O] ^<chemin de sortie du backup^> [-i|-I|/i^|/I] ^<chemin d'entrée du backup^>
echo %ScriptName% {/?^|-?^|/h^|-h^|/help^|-help}
echo.
echo     [-o|-O/o^|/O]      Définit le ^<chemin de sortie du backup^> qui doit être une chaine de charactère.
echo     [-i|-I|/i^|/I]     Définit le ^<chemin d'entrée du backup^>.
echo.    /?                 Affiche cette aide.
echo.

:End
if not "%~0"==":Help" endlocal
exit /b 0
