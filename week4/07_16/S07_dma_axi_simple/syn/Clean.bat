@ECHO OFF
@SET DIRS=xst.s3 xst.s6 xst.v4 xst.v5 xst.v6
@FOR %%d IN (%DIRS%) DO @(
	@IF EXIST %%d\Clean.bat (
		@PUSHD %%d
		@CALL .\Clean.bat
		@POPD
	)
)
