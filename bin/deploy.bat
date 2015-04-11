@echo off

REM Ensure we've set things up properly
if [%1] == [] goto Fail

REM Get authentication information
set connection=%1

REM Convert the working directory to something scp can use
REM First grab the invocation directory (/bin)
set cwd=%~dp0
REM Replace \ slashes with / slashes
set cwd=%cwd:\=/%
REM Replace c: with /c so we have a UNIX-style drive reference
set cwd=%cwd:c:=/c%

echo Copying provision scripts to the remote host: %host%

REM Copy both the provision directory and the bin directory to the remote server
scp -r %cwd%../provision/ %connection%:provision
scp -r %cwd% %connection%:scripts

echo Invoking scripts on the remote host.

REM Install dos2unix so we can fix line endings
ssh -t %connection% 'sudo apt-get install dos2unix -y'

REM Convert line endings of the deploy script
ssh -t %connection% 'dos2unix scripts/remote-provision.sh'

REM Fire the provision script so we can build the server
ssh -t %connection% 'sudo scripts/remote-provision.sh'

goto End

:Fail

echo Invalid invocation. Please specify a username (with sudo rights) and hostname.

:End