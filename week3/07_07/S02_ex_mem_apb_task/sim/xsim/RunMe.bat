@ECHO OFF
PUSHD "%~dp0"

CALL xelab -prj xsim.prj -debug typical top -s top
IF ERRORLEVEL 1 GOTO :END

CALL xsim top -t xsim_run.tcl
IF ERRORLEVEL 1 GOTO :END

:END
POPD
PAUSE
