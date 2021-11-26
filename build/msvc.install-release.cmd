@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

echo - %BUILD_PROJECT% ^> install-release

set PROJECT=%BUILD_PROJECT%

SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "tokens=* USEBACKQ" %%F IN (`xyo-version --no-bump --get "--version-file=version.ini" %PROJECT%`) DO (
	SET VERSION=%%F
)

set INSTALL_PATH=%XYO_PATH_RELEASE%\%PROJECT%-%VERSION%-%XYO_PLATFORM%
set INSTALL_PATH_BIN=%INSTALL_PATH%
set INSTALL_PATH_DEV=%XYO_PATH_RELEASE%\%PROJECT%-%VERSION%-%XYO_PLATFORM%-dev

rem // ---

call build\msvc.install.sub.cmd
