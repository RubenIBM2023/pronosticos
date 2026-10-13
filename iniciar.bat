@echo off
echo Iniciando servidor local en http://localhost:8080 ...
start /b python -m http.server 8080
timeout /t 2 /nobreak >nul
start "" "http://localhost:8080"
echo Servidor corriendo. Cierra esta ventana para detenerlo.
pause
