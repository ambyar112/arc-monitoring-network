@echo off
title Arc Network Monitor - Matikan App
color 0C
cls

echo ================================================
echo   Arc Network Monitor - Mematikan App
echo ================================================
echo.
echo  Mematikan semua proses Arc Network Monitor...
echo.

:: Matikan proses Python (backend)
taskkill /f /fi "WINDOWTITLE eq ARC BACKEND*" >nul 2>&1
taskkill /f /im python.exe >nul 2>&1

:: Matikan proses Node.js (frontend)
taskkill /f /fi "WINDOWTITLE eq ARC FRONTEND*" >nul 2>&1
taskkill /f /im node.exe >nul 2>&1

echo  OK - Semua layanan berhasil dimatikan!
echo.
echo  Tekan tombol apa saja untuk keluar...
pause >nul
