@echo off
setlocal enabledelayedexpansion

:: Define source and target directories
set "source_dir=build"
set "target_dir=output"

:: Create the target directory if it doesn't exist
if not exist "%target_dir%" mkdir "%target_dir%"

:: Platforms to process
for %%p in (android darwin linux windows) do (
    set "platform=%%p"
    if exist "%source_dir%\!platform!" (
        :: Iterate over files in the platform folder
        for %%f in ("%source_dir%\!platform!\*") do (
            set "filename=%%~nxf"
            set "extension=%%~xf"
            
            :: Remove the prefix 'tcp_over_ws_' and add platform/arch info
            set "new_filename=tcp_over_ws_!platform!_!filename:tcp_over_ws_=!"

            :: Copy file to the target directory with the new name
            copy "%%~f" "%target_dir%\!new_filename!" >nul
        )
    )
)

echo Files have been moved and renamed successfully.
pause
