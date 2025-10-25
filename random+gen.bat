@echo off
setlocal enabledelayedexpansion
set realset=abcdefghijklmnopqrstuvwxyz12345+-#@[]}{\/:',67890ABCDEFGHIJKLMNOPQRSTUVWXYZ
set backupset=abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ
set numrealset=75
set numbackupset=75
set number=%~1
set result=
set rand=%RANDOM%
:initialize
:repeat
set chrcount=0
:rerun
for /l %%i in (0,1,%number%) do (
if !chrcount! GEQ %number% goto next
call :math %%i
set result=!result!!test!
)
if !chrcount! LSS %number% goto rerun
:next
echo !result:~0,%number%!

REM ;for /f "tokens=*" %%i in (!result!) do (echo %%~i)
goto :eof
:math
for /f "tokens=1,4 delims=:. " %%i in ("%time%") do set /a num=(rand*!RANDOM!*(%1+1)*7919+1%%i%%j) %% numrealset
set test=
if !num! LSS 0 set /a num=-num
set /a next=num+1
CALL set "test=%%realset:~!num!,1%%"
if "!test!" NEQ "" (for /f "tokens=1,2" %%i in ("!num! !next!") do set realset=!realset:~0,%%i!!realset:~%%j!&set /a numrealset-=1&set /a chrcount+=1)
if "!realset!" == ""  set realset=%backupset%&set /a numrealset=numbackupset
goto :eof