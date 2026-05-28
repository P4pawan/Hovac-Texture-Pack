@echo off
setlocal enabledelayedexpansion
  
color 0B
title Texture Pack Deployer
 
echo.
echo ============================================================================
echo         MINECRAFT BEDROCK TEXTURE PACK INSTALLER
echo                      SweatyHovac
echo ============================================================================
echo.
 
set "DESTINATION=%appdata%\Minecraft Bedrock\users\shared\games\com.mojang\resource_packs"
 
if not exist "%DESTINATION%" (
    echo.
    echo [ERROR] Minecraft Bedrock directory not found at:
    echo %DESTINATION%
    echo.
    echo Please ensure Minecraft Bedrock Edition is installed.
    echo.
    pause
    exit /b 1
)
 
:GetPath
echo.
echo Please provide the absolute folder path of your custom texture pack.
echo Example: C:\Users\YourName\Downloads\MyTexturePackFolder
echo.
set /p SOURCE_PATH="Enter texture pack folder path: "
 
set "SOURCE_PATH=!SOURCE_PATH:"=!"
 
if not exist "!SOURCE_PATH!" (
    echo.
    echo [ERROR] The path you entered does not exist:
    echo !SOURCE_PATH!
    echo.
    echo Please check the path and try again.
    echo.
    goto GetPath
)
 
if not exist "!SOURCE_PATH!\*" (
    echo.
    echo [ERROR] The path is not a valid folder:
    echo !SOURCE_PATH!
    echo.
    echo Please enter a folder path, not a file.
    echo.
    goto GetPath
)
 
REM Extract folder name from path
for %%F in ("!SOURCE_PATH!") do set "FOLDER_NAME=%%~nxF"

set "FINAL_TARGET=%DESTINATION%\!FOLDER_NAME!"
 
echo.
echo ============================================================================
echo SOURCE:      !SOURCE_PATH!
echo DESTINATION: !FINAL_TARGET!
echo ============================================================================
echo.
echo Starting texture pack installation...
echo.
 
robocopy "!SOURCE_PATH!" "!FINAL_TARGET!" /E /DCOPY:DAT /COPY:DAT
 
if %ERRORLEVEL% LSS 8 (
    echo.
    echo ============================================================================
    echo [SUCCESS] Texture pack installed successfully!
    echo ============================================================================
    echo.
    echo Your texture pack is now installed at:
    echo !FINAL_TARGET!
    echo.
    echo You can now open Minecraft Bedrock and activate your texture pack
    echo in the Resource Packs settings.
    echo.
) else (
    echo.
    echo [ERROR] An error occurred while copying the texture pack.
    echo Error code: %ERRORLEVEL%
    echo.
)
 
echo.
pause
endlocal
exit /b 0