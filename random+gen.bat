@echo off
setlocal enabledelayedexpansion
set realset=abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ
set backupset=abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ
set numrealset=62
set numbackupset=62
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
set result="!result:~0,%number%!"
for /f "tokens=*" %%i in (!result!) do (echo %%~i)
goto :eof
:math
REM if %counternumset% GTR %numrealset% set /a counternumset=1
for /f "tokens=1,4 delims=:. " %%i in ("%time%") do set /a num=(rand*!RANDOM!*(%1+1)*7919+1%%i%%j) %% numrealset
set /a counternumset+=1
CALL set "test=%%realset:~!num!,1%%"
if "!test!" NEQ "" (for /f "delims=" %%i in ("!test!") do set realset=!realset:%%i=!&set /a numrealset-=1&set /a chrcount+=1) 
if "!realset!" == ""  set realset=%backupset%&set /a numrealset=numbackupset
if !num! LSS 0 set /a num=-num
goto :eof