@ECHO OFF

REM Setup VIAME Paths (no need to set if installed to registry or already set up)

SET VIAME_INSTALL=C:\Program Files\VIAME
SET VIAME_RUN_SCRIPTS=%VIAME_INSTALL%\configs

CALL "%VIAME_INSTALL%\setup_viame.bat"

REM Run GUI launcher

python.exe "%VIAME_RUN_SCRIPTS%\database_tool.py" start
python.exe "%VIAME_RUN_SCRIPTS%\ingest_video.py" --build-index ^
  -install "%VIAME_INSTALL%"
