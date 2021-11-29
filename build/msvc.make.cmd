@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

set ACTION=%1
if "%1" == "" set ACTION=make

echo - %BUILD_PROJECT% ^> %1

goto cmdXDefined
:cmdX
%*
if errorlevel 1 goto cmdXError
goto :eof
:cmdXError
echo "Error: %ACTION%"
exit 1
:cmdXDefined

if not "%ACTION%" == "make" goto :eof

call :cmdX xyo-cc --mode=%ACTION% --source-has-archive libssh2

if not exist output\ mkdir output
if not exist temp\ mkdir temp

set INCLUDE=%XYO_PATH_REPOSITORY%\include;%INCLUDE%
set LIB=%XYO_PATH_REPOSITORY%\lib;%LIB%
set WORKSPACE_PATH=%CD%
set WORKSPACE_PATH_OUTPUT=%WORKSPACE_PATH%\output
set WORKSPACE_PATH_BUILD=%WORKSPACE_PATH%\temp

if exist %WORKSPACE_PATH_BUILD%\build.done.flag goto :eof

if not exist temp\cmake mkdir temp\cmake
pushd temp\cmake

SET CC=cl.exe
SET CXX=cl.exe

SET CMD_CONFIG=cmake
SET CMD_CONFIG=%CMD_CONFIG% ../../source
SET CMD_CONFIG=%CMD_CONFIG% -G "Ninja"
SET CMD_CONFIG=%CMD_CONFIG% -DCMAKE_BUILD_TYPE=Release
SET CMD_CONFIG=%CMD_CONFIG% -DCMAKE_INSTALL_PREFIX=%WORKSPACE_PATH_OUTPUT%
SET CMD_CONFIG=%CMD_CONFIG% -DBUILD_EXAMPLES=OFF
SET CMD_CONFIG=%CMD_CONFIG% -DBUILD_TESTING=OFF

if not exist %WORKSPACE_PATH_BUILD%\build.configured.flag %CMD_CONFIG%
if errorlevel 1 goto makeError
if not exist %WORKSPACE_PATH_BUILD%\build.configured.flag echo configured > %WORKSPACE_PATH_BUILD%\build.configured.flag

ninja
if errorlevel 1 goto makeError
ninja install
if errorlevel 1 goto makeError
ninja clean
if errorlevel 1 goto makeError

goto buildDone

:makeError
popd
echo "Error: make"
exit 1

:buildDone
popd
echo done > %WORKSPACE_PATH_BUILD%\build.done.flag

