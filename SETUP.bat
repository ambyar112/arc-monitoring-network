@echo off
title Arc Network Monitor - Setup
color 0A
cls

echo ================================================
echo   Arc Network Transaction Monitor
echo   Setup Pertama Kali - Windows 11
echo ================================================
echo.

:: Refresh PATH agar deteksi instalasi baru
set "PATH=%PATH%;%ProgramFiles%\nodejs;%APPDATA%\npm;%ProgramFiles(x86)%\nodejs"

:: ── CEK PYTHON ──────────────────────────────────
echo [1/5] Mengecek Python...
where python >nul 2>&1
if errorlevel 1 (
    color 0C
    echo.
    echo  ERROR: Python tidak ditemukan!
    echo  Download dari: https://python.org/downloads
    echo  PENTING: Centang "Add Python to PATH"
    echo.
    pause
    exit /b 1
)
for /f "tokens=2 delims= " %%v in ('python --version 2^>^&1') do set PYVER=%%v
echo     OK - Python %PYVER% ditemukan!
echo.

:: ── CEK NODE.JS ─────────────────────────────────
echo [2/5] Mengecek Node.js...
where node >nul 2>&1
if errorlevel 1 (
    color 0C
    echo.
    echo  ERROR: Node.js tidak terdeteksi!
    echo.
    echo  Kemungkinan penyebab:
    echo  1. Belum di-install - download dari https://nodejs.org
    echo  2. Sudah install tapi belum restart komputer
    echo.
    echo  Coba RESTART komputer dulu, lalu jalankan
    echo  SETUP.bat ini lagi.
    echo.
    pause
    exit /b 1
)
for /f %%v in ('node --version 2^>^&1') do set NODEVER=%%v
echo     OK - Node.js %NODEVER% ditemukan!
echo.

:: ── SETUP BACKEND ───────────────────────────────
echo [3/5] Setup Backend Python...
cd /d "%~dp0backend"

if exist venv (
    echo     Membersihkan environment lama...
    rmdir /s /q venv
)

echo     Membuat virtual environment baru...
python -m venv venv
if errorlevel 1 (
    color 0C
    echo     GAGAL membuat virtual environment!
    pause
    exit /b 1
)

echo     Mengaktifkan virtual environment...
call venv\Scripts\activate.bat

echo     Upgrade pip ke versi terbaru...
python -m pip install --upgrade pip --quiet

echo     Menginstall library backend...
pip install -r requirements.txt
if errorlevel 1 (
    color 0C
    echo.
    echo  GAGAL install library!
    echo  Screenshot error di atas lalu tanyakan ke developer.
    pause
    exit /b 1
)

if not exist .env (
    copy .env.example .env >nul
)

call venv\Scripts\deactivate.bat
echo     OK - Backend siap!
echo.

:: ── SETUP FRONTEND ──────────────────────────────
echo [4/5] Setup Frontend React...
cd /d "%~dp0frontend"

echo     Menginstall library Node.js (butuh 2-5 menit)...
call npm install
if errorlevel 1 (
    color 0C
    echo     GAGAL install library frontend!
    pause
    exit /b 1
)
echo     OK - Frontend siap!
echo.

:: ── BUAT FILE JALANKAN.bat ──────────────────────
echo [5/5] Membuat file JALANKAN.bat...
cd /d "%~dp0"

(
echo @echo off
echo title Arc Network Monitor
echo color 0A
echo cls
echo set "PATH=%%PATH%%;%%ProgramFiles%%\nodejs;%%APPDATA%%\npm"
echo echo ================================================
echo echo   Arc Network Monitor - Menyalakan App...
echo echo ================================================
echo echo.
echo if not exist "%%~dp0backend\venv" ^(
echo     color 0C
echo     echo ERROR: Jalankan SETUP.bat dulu^^!
echo     pause
echo     exit /b 1
echo ^)
echo echo  ^[1/3^] Menyalakan Backend...
echo start "ARC BACKEND" cmd /k "color 0B && title ARC BACKEND - Jangan Ditutup && cd /d """%%~dp0backend""" && call venv\Scripts\activate.bat && python main.py"
echo echo  Menunggu backend siap...
echo timeout /t 4 /nobreak ^>nul
echo echo  ^[2/3^] Menyalakan Frontend...
echo start "ARC FRONTEND" cmd /k "color 0D && title ARC FRONTEND - Jangan Ditutup && set PATH=%%PATH%%;%%ProgramFiles%%\nodejs;%%APPDATA%%\npm && cd /d """%%~dp0frontend""" && npm run dev"
echo echo  Menunggu frontend siap...
echo timeout /t 6 /nobreak ^>nul
echo echo  ^[3/3^] Membuka browser...
echo start http://localhost:5173
echo echo.
echo echo ================================================
echo echo   APP BERJALAN^^!
echo echo.
echo echo   Buka browser ke: http://localhost:5173
echo echo   API Docs       : http://localhost:8000/docs
echo echo.
echo echo   PENTING: Jangan tutup 2 jendela CMD yang terbuka^^!
echo echo ================================================
echo echo.
echo pause
) > JALANKAN.bat

echo     OK - JALANKAN.bat siap!
echo.

color 0A
echo ================================================
echo   SETUP SELESAI BERHASIL! (^_^)
echo ================================================
echo.
echo   Cara pakai selanjutnya:
echo.
echo     Klik 2x  JALANKAN.bat  untuk buka app
echo     Klik 2x  MATIKAN.bat   untuk tutup app
echo.
echo   Browser akan otomatis terbuka ke:
echo   http://localhost:5173
echo.
set /p jawab=  Mau langsung coba sekarang? (Y/N): 
if /i "%jawab%"=="y" (
    call "%~dp0JALANKAN.bat"
)
echo.
pause
