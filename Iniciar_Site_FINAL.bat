@echo off
title EMERICK - Iniciar Site (Frontend) [FINAL]
setlocal

echo ===============================================
echo   EMERICK - FRONTEND (SITE) - START
echo ===============================================

where npm >nul 2>&1
if %errorlevel% neq 0 (
  echo [ERRO] NPM nao encontrado. Instale Node.js LTS (22.x) de nodejs.org.
  pause
  exit /b 1
)

cd /d "%~dp0\sistema-web" || (
  echo [ERRO] Nao achei a pasta "sistema-web" ao lado deste arquivo.
  pause
  exit /b 1
)

if not exist ".env.local" (
  echo VITE_API_BASE=http://localhost:5000> .env.local
)

if exist package-lock.json (
  echo [1/2] Instalando dependencias (npm ci)...
  npm ci
) else (
  echo [1/2] Instalando dependencias (npm install)...
  npm install
)

echo [2/2] Iniciando interface (http://localhost:5173)...
npm run dev

pause
