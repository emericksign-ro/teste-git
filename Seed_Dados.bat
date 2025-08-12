@echo off
title EMERICK - Seed de Dados (opcional)
setlocal

cd /d "%~dp0\sistema_completo" || (echo Pasta sistema_completo nao encontrada. & pause & exit /b 1)

if exist "venv\Scripts\python.exe" (
  call venv\Scripts\activate
) else if exist "%LOCALAPPDATA%\Emerick\venv311\Scripts\python.exe" (
  call "%LOCALAPPDATA%\Emerick\venv311\Scripts\activate"
) else (
  echo venv nao encontrado. Rode primeiro "Iniciar_API_FINAL.bat".
  pause
  exit /b 1
)

if not exist "tools\seed_via_api.py" (
  echo [ERRO] Nao encontrei tools\seed_via_api.py. Copie-o de "copia_para_sistema_completo".
  pause
  exit /b 1
)

python tools\seed_via_api.py
pause
