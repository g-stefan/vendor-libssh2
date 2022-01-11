@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

echo - %BUILD_PROJECT% ^> clean-local-release

if "%SKIP_VENDOR%"=="TRUE" goto:eof
if exist release\ rmdir /Q /S release
