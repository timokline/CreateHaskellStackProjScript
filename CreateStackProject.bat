@ECHO OFF
setlocal
::This batch file creates a new Haskell project using Stack.
::Asks for name of project

ECHO ============================
ECHO CREATE HASKELL STACK PROJECT
ECHO ============================

SET /P NAME=Enter the project folder name: 
SET _STKCMD=stack new "%NAME%" new-template

::No need?
::TODO: Figure out way to do this -> SET GIT= -p ""scm-init:git""
::SET GIT=scm-init:git
::SET /P INIT_SC=Initialize source control (git)? (Y/[N])? 
::IF /I "%INIT_SC%" NEQ "Y" GOTO CMDLINE
::SET _STKCMD=stack new "%NAME%" new-template -p """%GIT%"""

:CMDLINE
ECHO Creating a new Haskell project folder with following command: & ECHO.
ECHO.%_STKCMD% & ECHO.
::User: Joe [https://stackoverflow.com/questions/1794547/how-can-i-make-an-are-you-sure-prompt-in-a-windows-batchfile/1807318]
:PROMPT
SET /P CONFIRM=Project will be built with these parameters. Are you sure (Y/[N])? 
IF /I "%CONFIRM%" NEQ "Y" GOTO END

%_STKCMD%
::User: Joey [https://stackoverflow.com/questions/14691494/check-if-command-was-successful-in-a-batch-file]
IF errorlevel 1 GOTO END

ECHO.
SET /P SETUP=Setup project folder? (Y/[N])? 
IF /I "%SETUP%" NEQ "Y" GOTO FINISH

cd "%NAME%"
IF errorlevel 1 GOTO FINISH
stack setup
ECHO.
GOTO FINISH

:END
ECHO. & ECHO Creation cancelled.

:FINISH
endlocal
ECHO Done.
PAUSE