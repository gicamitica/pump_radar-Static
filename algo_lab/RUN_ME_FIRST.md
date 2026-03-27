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
