@echo off
:: Codyssey E1-1 setup - install or upgrade Git, VSCode, Docker Desktop, WSL Ubuntu
:: Re-run as administrator if needed
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set WINGET_OPTS=-e --accept-source-agreements --accept-package-agreements

call :install_or_upgrade Git.Git "Git"
call :install_or_upgrade Microsoft.VisualStudioCode "VSCode"
call :install_or_upgrade Docker.DockerDesktop "Docker Desktop"

echo.
echo [WSL] Updating WSL
wsl --update

echo.
echo [WSL] Checking Ubuntu
wsl -d Ubuntu -- exit >nul 2>&1
if %errorlevel% neq 0 (
    echo Ubuntu not found - installing
    wsl --install Ubuntu --no-launch
) else (
    echo Ubuntu found - skip
)

echo.
echo Done. If anything was newly installed, reboot and launch Ubuntu / Docker Desktop once.
pause
exit /b

:install_or_upgrade
echo.
echo [%~2] Checking
winget list --id %1 -e --accept-source-agreements >nul 2>&1
if %errorlevel% neq 0 (
    echo %~2 not found - installing
    winget install --id %1 %WINGET_OPTS%
) else (
    echo %~2 found - checking for upgrade
    winget upgrade --id %1 %WINGET_OPTS%
)
exit /b
