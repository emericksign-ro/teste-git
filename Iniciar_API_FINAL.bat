@echo off
title EMERICK - Iniciar API (Backend) [FINAL]
setlocal enabledelayedexpansion

echo ===============================================
echo   EMERICK - BACKEND (API) - START
echo ===============================================

where python >nul 2>&1
if %errorlevel% neq 0 (
  where py >nul 2>&1
  if %errorlevel% neq 0 (
    echo [ERRO] Python nao encontrado. Instale Python 3.11 (64-bit) e marque "Add to PATH".
    pause
    exit /b 1
  ) else (
    set PYTHON=py -3
  )
) else (
  set PYTHON=python
)

cd /d "%~dp0\sistema_completo" || (
  echo [ERRO] Nao achei a pasta "sistema_completo" ao lado deste arquivo.
  pause
  exit /b 1
)

set VENV_LOCAL=venv
set VENV_GLOBAL=%LOCALAPPDATA%\Emerick\venv311

if not exist "%VENV_LOCAL%\Scripts\python.exe" (
  %PYTHON% -m venv "%VENV_LOCAL%" >nul 2>&1
)
if exist "%VENV_LOCAL%\Scripts\python.exe" (
  call "%VENV_LOCAL%\Scripts\activate"
) else (
  echo (aviso) venv local falhou. Usando venv global em %VENV_GLOBAL% ...
  if not exist "%VENV_GLOBAL%\Scripts\python.exe" (
    %PYTHON% -m venv "%VENV_GLOBAL%" || (echo [ERRO] Falha ao criar venv. & pause & exit /b 1)
  )
  call "%VENV_GLOBAL%\Scripts\activate"
)

echo [2/6] Atualizando instalador de pacotes...
python -m pip install --upgrade pip setuptools wheel

echo [3/6] Instalando dependencias...
if exist requirements.txt (
  pip install -r requirements.txt
) else (
  echo (aviso) Sem requirements.txt - instalando basico.
  pip install Flask==2.3.3 Flask-Cors==4.0.0 SQLAlchemy==2.0.32 PyJWT==2.8.0 reportlab==3.6.13 openpyxl==3.1.5
)

if not exist ".env" (
  > .env echo FLASK_ENV=development
  >> .env echo DEBUG=true
  >> .env echo SECRET_KEY=troque_este_valor
  >> .env echo JWT_SECRET=troque_este_valor_tb
  >> .env echo DATABASE_URL=sqlite:///data.db
  >> .env echo CORS_ALLOWED_ORIGINS=http://localhost:5173
)

echo [5/6] Procurando arquivo principal...
set ENTRY=
for %%F in (main.py app.py api.py server.py) do (
  if exist "%%F" set ENTRY=%%F
)
if "%ENTRY%"=="" (
  for %%F in (src\main.py src\app.py src\api.py src\server.py) do (
    if exist "%%F" set ENTRY=%%F
  )
)

if "%ENTRY%"=="" (
  echo (aviso) Nao encontrei main/app. Vou iniciar com FLASK MODULE.
  set FLASK_APP=main.py
  if exist "src\main.py" set FLASK_APP=src/main.py
  if exist "app.py" set FLASK_APP=app.py
  if exist "src\app.py" set FLASK_APP=src/app.py
  set FLASK_RUN_PORT=5000
  echo [6/6] Subindo API em http://localhost:5000 ...
  python -m flask run --host=127.0.0.1 --port=5000
) else (
  echo [6/6] Iniciando Python "%ENTRY%" em http://localhost:5000 ...
  python "%ENTRY%"
)

echo.
echo API finalizada.
pause
