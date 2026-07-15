@ECHO OFF
@SET DIRS=modelsim
@FOR %%d IN ( %DIRS% ) DO @(
	@IF EXIST %%d\Clean.bat (
		@PUSHD %%d
		@CALL .\Clean.bat
		@POPD
	)
)
