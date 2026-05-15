@echo off
title Arc Network Monitor
color 0A
cls
set "PATH=%PATH%;%ProgramFiles%\nodejs;%APPDATA%\npm"
echo ================================================
echo   Arc Network Monitor - Menyalakan App...
echo ================================================
echo.
if not exist "%~dp0backend\venv" (
    color 0C
    echo ERROR: Jalankan SETUP.bat dulu^!
    pause
    exit /b 1
)
echo  [1/3] Menyalakan Backend...
start "ARC BACKEND" cmd /k "color 0B && title ARC BACKEND - Jangan Ditutup && cd /d """%~dp0backend""" && call venv\Scripts\activate.bat && python main.py"
echo  Menunggu backend siap...
timeout /t 4 /nobreak >nul
echo  [2/3] Menyalakan Frontend...
start "ARC FRONTEND" cmd /k "color 0D && title ARC FRONTEND - Jangan Ditutup && set PATH=%PATH%;%ProgramFiles%\nodejs;%APPDATA%\npm && cd /d """%~dp0frontend""" && npm run dev"
echo  Menunggu frontend siap...
timeout /t 6 /nobreak >nul
echo  [3/3] Membuka browser...
start http://localhost:5173
echo.
echo ================================================
echo   APP BERJALAN^!
echo.
echo   Buka browser ke: http://localhost:5173
echo   API Docs       : http://localhost:8000/docs
echo.
echo   PENTING: Jangan tutup 2 jendela CMD yang terbuka^!
echo ================================================
echo.
pause
