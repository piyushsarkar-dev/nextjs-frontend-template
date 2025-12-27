@echo off
setlocal EnableDelayedExpansion

:: Define ANSI Colors
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"
set "RESET=%ESC%[0m"
set "BOLD=%ESC%[1m"
set "RED=%ESC%[31m"
set "GREEN=%ESC%[32m"
set "YELLOW=%ESC%[33m"
set "BLUE=%ESC%[34m"
set "MAGENTA=%ESC%[35m"
set "CYAN=%ESC%[36m"
set "WHITE=%ESC%[37m"

:: Clear screen
cls

:: ============================================================================
:: HEADER - CREATOR INFO (Centered & Colorful)
:: ============================================================================
echo.
echo.
echo  %CYAN%  ======================================================================%RESET%
echo  %MAGENTA%   ____  _                 _       ____            _               %RESET%
echo  %MAGENTA%  ^|  _ \(_)_   _ _   _ ___^| ^|__   / ___^|  __ _ _ __^| ^| ____ _ _ __  %RESET%
echo  %MAGENTA%  ^| ^|_) ^| ^| ^| ^| ^| ^| ^| / __^| '_ \  \___ \ / _` ^| '__^| ^|/ / _` ^| '__^| %RESET%
echo  %MAGENTA%  ^|  __/^| ^| ^|_^| ^| ^|_^| \__ \ ^| ^| ^|  ___) ^| (_^| ^| ^|  ^|   ^< (_^| ^| ^|    %RESET%
echo  %MAGENTA%  ^|_^|   ^|_^|\__, ^|\__,_^|___/_^| ^|_^| ^|____/ \__,_^|_^|  ^|_^|\_\__,_^|_^|    %RESET%
echo  %MAGENTA%           ^|___/                                                    %RESET%
echo  %CYAN%  ======================================================================%RESET%
echo.
echo          %YELLOW%Creator : Piyush Sarkar%RESET%
echo          %GREEN%Next.js Frontend Template Setup%RESET%
echo.
echo.

:: ============================================================================
:: 1. OPEN TOOLS
:: ============================================================================
echo  %BLUE%[INFO] Opening Visual Studio Code...%RESET%
call code .
if %ERRORLEVEL% NEQ 0 (
    echo  %RED%[WARNING] Could not open Visual Studio Code. Make sure 'code' is in your PATH.%RESET%
)

:: ============================================================================
:: 2. CHECK RUNTIMES
:: ============================================================================
echo.
echo  %BLUE%[INFO] Checking for installed runtimes...%RESET%

set "NODE_FOUND=0"
set "BUN_FOUND=0"

:: Check for Node.js
where node >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    set "NODE_FOUND=1"
    for /f "tokens=*" %%v in ('node -v') do echo        %GREEN%Found Node.js: %%v%RESET%
)

:: Check for Bun
where bun >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    set "BUN_FOUND=1"
    for /f "tokens=*" %%v in ('bun -v') do echo        %GREEN%Found Bun: %%v%RESET%
)

:: Verify at least one runtime exists
if %NODE_FOUND% EQU 0 (
    if %BUN_FOUND% EQU 0 (
        echo.
        echo  %RED%[ERROR] Node.js or Bun is required.%RESET%
        echo  %RED%        Please install one of them and rerun this file.%RESET%
        pause
        exit /b 1
    )
)

:: ============================================================================
:: 3. DEPENDENCY UPDATE CHECK
:: ============================================================================
echo.
echo  %BLUE%[INFO] Checking for dependency updates (interactive mode)...%RESET%
call npx npm-check-updates@latest -i

:: ============================================================================
:: 4. USER INPUT -> package.json UPDATE
:: ============================================================================
echo.
echo  %CYAN%-------------------------------------------------%RESET%
echo  %BOLD%[SETUP] Please configure your project details.%RESET%
echo  %CYAN%-------------------------------------------------%RESET%

set /p "PROJECT_NAME= %YELLOW%Project Name: %RESET%"
set /p "PROJECT_AUTHOR= %YELLOW%Author Name:  %RESET%"
set /p "PROJECT_HOMEPAGE= %YELLOW%Homepage URL: %RESET%"

echo.
echo  %BLUE%[INFO] Updating package.json...%RESET%

powershell -Command "$json = Get-Content 'package.json' -Raw | ConvertFrom-Json; $json.name = '%PROJECT_NAME%'; $json.author = '%PROJECT_AUTHOR%'; $json.homepage = '%PROJECT_HOMEPAGE%'; $json | ConvertTo-Json -Depth 10 | Set-Content 'package.json'"

:: ============================================================================
:: 5. PACKAGE MANAGER SELECTION
:: ============================================================================
echo.
:SELECT_PM
echo  %CYAN%-------------------------------------------------%RESET%
echo  %BOLD%[SETUP] Package Manager Selection%RESET%
echo  %CYAN%-------------------------------------------------%RESET%
set /p "PM_CHOICE= %YELLOW%Which package manager? (npm / bun): %RESET%"

if /i "%PM_CHOICE%"=="npm" (
    echo.
    echo  %GREEN%[INFO] Installing dependencies using npm...%RESET%
    call npm install
    goto :START_DEV
)

if /i "%PM_CHOICE%"=="bun" (
    echo.
    echo  %GREEN%[INFO] Installing dependencies using bun...%RESET%
    call bun install
    goto :START_DEV
)

echo  %RED%[ERROR] Invalid selection. Please type 'npm' or 'bun'.%RESET%
goto :SELECT_PM

:: ============================================================================
:: 6. START DEVELOPMENT SERVER
:: ============================================================================
:START_DEV
echo.
echo  %CYAN%======================================================================%RESET%
echo  %GREEN%   STARTING DEVELOPMENT SERVER%RESET%
echo  %CYAN%======================================================================%RESET%
echo.
echo  %BLUE%[INFO] The server logs will appear below.%RESET%
echo  %BLUE%[INFO] Closing Visual Studio Code will automatically close this terminal.%RESET%
echo.

if /i "%PM_CHOICE%"=="npm" (
    start /b cmd /c npm run dev
) else (
    start /b bun run dev
)

:: Wait for VS Code to close
call code -w .
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo  %RED%[WARNING] Visual Studio Code command 'code' was not found or failed.%RESET%
    echo  %YELLOW%The server is running. Press any key to stop it and exit.%RESET%
    pause >nul
)

:: Exit the script and close the terminal
exit