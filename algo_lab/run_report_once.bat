@echo off
setlocal
set "ROOT=%~dp0"
cd /d "%ROOT%backend" || (
  echo [ERROR] Cannot find backend folder at "%ROOT%backend"
  exit /b 1
)

where py >nul 2>nul
if %errorlevel%==0 (
  set "PY_CMD=py"
) else (
  set "PY_CMD=python"
)

if not exist .venv (
  %PY_CMD% -m venv .venv
)

call .venv\Scripts\activate.bat
pip install -r requirements.txt
python ..\reporter\hourly_reporter.py --once
endlocal
