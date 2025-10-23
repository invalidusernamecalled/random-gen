@echo off
setlocal enabledelayedexpansion
set realset=abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ
set numrealset=62
set number=%~1
set result=
set rand=%RANDOM%
:initialize
:repeat
set chrcount=0
for /l %%i in (1,1,%number%) do (
if !chrcount! GTR %number% goto :eof
set /a chrcount+=1
call :math %%i
CALL set result=!result!%%realset:~!num!,1%%
)
:next
set result="!result:~0,%number%!"
for /f "tokens=*" %%i in (!result!) do (echo %%~i)
goto :eof
:math
for /f "tokens=1,4 delims=:." %%i in ("%time%") do set /a num=(rand*!RANDOM!*(%1+1)*7919+%%i%%j) %% numrealset
if !num! LSS 0 set /a num=-num
goto :eof