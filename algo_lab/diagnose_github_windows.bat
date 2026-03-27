@echo off
setlocal

echo [1/3] DNS check for github.com
nslookup github.com

echo.
echo [2/3] HTTPS connectivity test (PowerShell)
powershell -Command "try { (Invoke-WebRequest -Uri 'https://github.com' -UseBasicParsing -TimeoutSec 15).StatusCode } catch { Write-Host $_.Exception.Message; exit 1 }"

echo.
echo [3/3] Git check
git --version

echo.
echo If step 2 fails, your network/firewall/proxy blocks GitHub (port 443).
endlocal
