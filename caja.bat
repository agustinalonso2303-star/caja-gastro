@echo off
title CAJA POS
color 0A

echo ===================================
echo      CAJA POS - SISTEMA DE VENTA
@echo off
title Caja POS - Sistema Gastronómico
color 0A

echo      ====================================
echo      🍽️  CAJA POS - GASTRONOMÍA  🍽️
echo      ====================================
echo.

cd /d "%~dp0"

echo 🌐 Abriendo caja online...
echo URL: https://caja-gastro-1.onrender.com
echo.
echo ⚠️  NOTA: La primera carga puede tardar 30-60 segundos
echo     (Render está despertando la instancia)
echo.

start https://caja-gastro-1.onrender.com

timeout /t 3 >nul

echo 📋 Opciones adicionales:
echo.
echo 1. Abrir caja local (rápido)
echo 2. Ver estado del deploy
echo 3. Sincronizar con GitHub
echo 4. Salir
echo.
set /p opcion=Seleccione una opción (1-4): 

if "%opcion%"=="1" goto abrir_local
if "%opcion%"=="2" goto estado_deploy
if "%opcion%"=="3" goto sincronizar_git
if "%opcion%"=="4" goto salir

:abrir_local
echo.
echo 🏠 Abriendo caja local...
if exist "caja.html" (
    start caja.html
    echo ✅ Caja local abierta correctamente.
) else (
    echo ❌ ERROR: No se encuentra caja.html
    echo    El archivo HTML debe estar en esta carpeta.
)
goto fin

:estado_deploy
echo.
echo 📊 Verificando estado del deploy...
echo URL: https://caja-gastro-1.onrender.com
start https://caja-gastro-1.onrender.com
echo ✅ Abriendo URL en navegador para verificar estado...
goto fin

:sincronizar_git
echo.
echo 📤 Sincronizando con GitHub...
echo.

git status
if errorlevel 1 (
    echo ❌ Git no está inicializado o hay errores
    echo    Ejecuta: git init y git remote add origin
    goto fin
)

git add .
git commit -m "Auto-update desde caja local - %date% %time%"
git push origin master

if errorlevel 1 (
    echo ❌ Error al hacer push a GitHub
    echo    Verifica tu conexión y credenciales
) else (
    echo ✅ Cambios subidos a GitHub correctamente
    echo 🔄 Render activará auto-deploy en 1-2 minutos
)
goto fin

:salir
echo 👋 Cerrando sistema...
goto fin

:fin
echo.
echo ====================================
echo Listo. Presiona cualquier tecla para salir...
pause >nul
