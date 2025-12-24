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

powershell -NoProfile -ExecutionPolicy Bypass -Command "$q=[char]34; $c = Get-Content 'package.json' -Raw; $c = $c -replace ($q+'name'+$q+':\s*'+$q+'.*?'+$q), ($q+'name'+$q+': '+$q+'%PROJECT_NAME%'+$q); $c = $c -replace ($q+'author'+$q+':\s*'+$q+'.*?'+$q), ($q+'author'+$q+': '+$q+'%PROJECT_AUTHOR%'+$q); $c = $c -replace ($q+'homepage'+$q+':\s*'+$q+'.*?'+$q), ($q+'homepage'+$q+': '+$q+'%PROJECT_HOMEPAGE%'+$q); $c | Set-Content 'package.json'"

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
    set "RUN_CMD=npm run dev"
    goto :SETUP_VSCODE
)

if /i "%PM_CHOICE%"=="bun" (
    echo.
    echo  %GREEN%[INFO] Installing dependencies using bun...%RESET%
    call bun install
    set "RUN_CMD=bun run dev"
    goto :SETUP_VSCODE
)

echo  %RED%[ERROR] Invalid selection. Please type 'npm' or 'bun'.%RESET%
goto :SELECT_PM

:: ============================================================================
:: 6. SETUP VS CODE & EXIT
:: ============================================================================
:SETUP_VSCODE
echo.
echo  %BLUE%[INFO] Configuring Visual Studio Code tasks...%RESET%

if not exist .vscode mkdir .vscode

:: Create run_server.bat to handle browser opening and server execution
(
echo @echo off
echo echo [INFO] Opening default browser at http://localhost:3000...
echo start http://localhost:3000
echo echo [INFO] Starting development server...
echo %%*
echo echo.
echo echo [INFO] Server stopped. Press any key to close this terminal...
echo pause ^>nul
) > .vscode\run_server.bat

:: Create tasks.json using PowerShell to handle JSON content safely
powershell -NoProfile -ExecutionPolicy Bypass -Command "$tasks = @{ version = '2.0.0'; tasks = @( @{ label = 'Start Development Server'; type = 'shell'; command = '.vscode\run_server.bat %RUN_CMD%'; problemMatcher = @(); group = @{ kind = 'build'; isDefault = $true }; runOptions = @{ runOn = 'folderOpen' }; presentation = @{ reveal = 'always'; panel = 'dedicated' } } ) }; $tasks | ConvertTo-Json -Depth 10 | Set-Content '.vscode/tasks.json'"

echo  %GREEN%[SUCCESS] Setup complete! Opening Visual Studio Code...%RESET%
echo  %BLUE%[INFO] The development server will start automatically in the VS Code terminal.%RESET%

call code .
exit