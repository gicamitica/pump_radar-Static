# RUN ME FIRST (2 comenzi)

## Windows (CMD) - de la zero
```bat
cd /d C:\Users\dan.mina
git clone https://github.com/gicamitica/pump_radar-Static.git
cd /d C:\Users\dan.mina\pump_radar-Static\algo_lab
run_report_once.bat
```

## Linux / Mac
```bash
git clone https://github.com/gicamitica/pump_radar-Static.git
cd pump_radar-Static/algo_lab
./run_report_once.sh
```

## Unde vezi rezultatul
- `algo_lab/reports/output/latest.xlsx`

## Notă
- `OPENAI_API_KEY` este opțional.
- dacă nu ai key, rulează fallback heuristic și tot generează Excel.

## Dacă `git clone` dă eroare de conectare la GitHub (port 443)
Rulează diagnosticul:
```bat
cd /d C:\Users\dan.mina
diagnose_github_windows.bat
```

Fallback (fără git), descarci ZIP direct:
```bat
cd /d C:\Users\dan.mina
powershell -Command "Invoke-WebRequest -Uri 'https://codeload.github.com/gicamitica/pump_radar-Static/zip/refs/heads/main' -OutFile 'pump_radar-Static.zip'"
powershell -Command "Expand-Archive -Path 'pump_radar-Static.zip' -DestinationPath '.' -Force"
cd /d C:\Users\dan.mina\pump_radar-Static-main\algo_lab
run_report_once.bat
```
