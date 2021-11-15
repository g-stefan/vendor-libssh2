@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

echo -^> vendor vendor-libssh2

goto getSizeDefined
:getSize
set FILE_SIZE=%~z1
goto:eof
:getSizeDefined

if not exist archive\ mkdir archive

rem Self
if exist archive\%PROJECT%-%VERSION%.7z goto:eof
curl --insecure --location https://github.com/g-stefan/vendor-%PROJECT%/releases/download/v%VERSION%/%PROJECT%-%VERSION%.7z --output archive\%PROJECT%-%VERSION%.7z
call :getSize "archive\%PROJECT%-%VERSION%.7z"
if %FILE_SIZE% GTR 16 goto:eof
del /F /Q archive\%PROJECT%-%VERSION%.7z goto:eof

rem Source
pushd archive
set VENDOR=%PROJECT%-%VERSION%
set WEB_LINK=https://github.com/libssh2/libssh2/releases/download/libssh2-1.10.0/libssh2-1.10.0.tar.gz
if not exist %VENDOR%.tar.gz curl --insecure --location %WEB_LINK% --output %VENDOR%.tar.gz
7z x %VENDOR%.tar.gz -so | 7z x -aoa -si -ttar -o.
del /F /Q %VENDOR%.tar.gz
del /F /Q pax_global_header 
if exist %VENDOR%.7z del /F /Q %VENDOR%.7z
7zr a -mx9 -mmt4 -r- -sse -w. -y -t7z %VENDOR%.7z %VENDOR%
rmdir /Q /S %VENDOR%
popd
