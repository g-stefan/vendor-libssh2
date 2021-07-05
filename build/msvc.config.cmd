@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

set PROJECT=libssh2

set VERSION=0.0.0
setlocal enabledelayedexpansion
for /F "tokens=* USEBACKQ" %%F in (`xyo-version --no-bump --get "--version-file=version.ini"`) do (
	set VERSION=%%F
)
for /F "delims=" %%i in ('echo %VERSION%') do endlocal && set VERSION=%%i
