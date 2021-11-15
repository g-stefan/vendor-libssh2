@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

echo -^> release vendor-libssh2

goto cmdXDefined
:cmdX
%*
if errorlevel 1 goto cmdXError
goto :eof
:cmdXError
echo "Error: release"
exit 1
:cmdXDefined

set XYO_PATH_RELEASE=release

xyo-cc libssh2 --has-archived-release --version-file=version.ini
if errorlevel 1 exit 0
call :cmdX cmd.exe /C build\msvc.cmd vendor
call :cmdX cmd.exe /C build\msvc.cmd make
call :cmdX cmd.exe /C build\msvc.cmd sign
call :cmdX cmd.exe /C build\msvc.cmd install
call :cmdX cmd.exe /C build\msvc.cmd install-release
call :cmdX if not exist release\%PROJECT%-%VERSION%.7z copy /B /Y archive\%PROJECT%-%VERSION%.7z release\%PROJECT%-%VERSION%.7z
call :cmdX xyo-cc libssh2 --archive-release-sha512 --version-file=version.ini
