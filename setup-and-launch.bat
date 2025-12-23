@echo off
setlocal EnableDelayedExpansion

:: ==========================================
:: Next.js Project Launcher and Initializer
:: ==========================================

:: 1. Open Visual Studio Code in the current directory
echo Opening Visual Studio Code...
call code .

:: 2. Check for dependency updates interactively
echo.
echo Checking for dependency updates...
call npx npm-check-updates@latest -i

:: 3. Update package.json "name" with the current folder name
echo.
echo Updating package.json name...
for %%I in (.) do set "FolderName=%%~nxI"

:: Use Node.js to safely update the JSON file (avoids complex batch parsing)
node -e "const fs = require('fs'); try { const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8')); pkg.name = process.argv[1]; fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2)); console.log('Updated name to: ' + pkg.name); } catch (e) { console.error('Error updating package.json:', e); }" "%FolderName%"

:: 4. Prompt user for Author and GitHub URL
echo.
set /p AuthorName="Enter Author Name: "
set /p RepoUrl="Enter GitHub Repository URL: "

:: 5. Update package.json "author" and "homepage"
echo.
echo Updating author and homepage in package.json...
node -e "const fs = require('fs'); try { const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8')); pkg.author = process.argv[1]; pkg.homepage = process.argv[2]; fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2)); console.log('Updated author and homepage.'); } catch (e) { console.error('Error updating package.json:', e); }" "%AuthorName%" "%RepoUrl%"

:: 6. Install dependencies
echo.
echo Installing dependencies (npm install)...
call npm install

:: 7. Initialize Git, Commit, and Push
echo.
echo Initializing Git repository...

:: Initialize git if not already present
if not exist .git (
    git init
) else (
    echo Git repository already initialized.
)

:: Add all files
git add .

:: Create initial commit
git commit -m "Initial commit"

:: Rename branch to main
git branch -M main

:: Add remote and push if URL is provided
if not "%RepoUrl%"=="" (
    echo Setting remote origin to %RepoUrl%...
    
    :: Remove existing origin if it exists to avoid errors
    git remote remove origin 2>nul
    
    git remote add origin %RepoUrl%
    
    echo Pushing to GitHub...
    git push -u origin main
) else (
    echo No GitHub URL provided. Skipping push.
)

echo.
echo ==========================================
echo Project initialization complete!
echo Starting development server...
echo ==========================================
call npm run dev
pause
