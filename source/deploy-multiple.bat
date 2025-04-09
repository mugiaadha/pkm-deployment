@echo off
setlocal enabledelayedexpansion

:: === LOOP MULTIPLE DEPLOY ===
:: Membaca setiap baris dari file deploy-list.txt
for /f "usebackq delims=" %%L in ("deploy-list.txt") do (
  call :deploy "%%~L"
)

echo.
echo === SEMUA SELESAI ===
pause
exit /b

:deploy
setlocal

set "line=%~1"
set "line=%line:"=%"

for /f "tokens=1-6 delims=|" %%a in ("%line%") do (
  set "old_name=%%a"
  set "new_name=%%b"
  set "old_db=%%c"
  set "new_db=%%d"
  set "old_code=%%e"
  set "new_code=%%f"
)

echo.
echo === DEPLOYING: !new_name! from !old_name! ===

:: === COPY FOLDER ===
echo Copying folder...
xcopy "!old_name!" "../result/!new_name!" /E /I /H /Y >nul

:: === FILE REPLACEMENT ===
for %%f in (
  "koneksi.php"
  "ws\koneksi.php"
  "api\config.php"
  "wsv2\pasien.php"
  "report\loadetiket.php"
  ) do (
  set "filepath=../result/!new_name!\clenic\%%~f"
  call :replacefile "!filepath!" "!old_db!" "!new_db!" "!old_code!" "!new_code!"
)

endlocal
exit /b

:replacefile
setlocal
set "filepath=%~1"
set "old_db=%~2"
set "new_db=%~3"
set "old_code=%~4"
set "new_code=%~5"

if exist "%filepath%" (
  echo Updating: %filepath%
  powershell -Command "(Get-Content -Raw '%filepath%') -replace '%old_db%', '%new_db%' -replace '%old_code%', '%new_code%' | Set-Content '%filepath%'"
) else (
  echo File not found: %filepath%
)
endlocal
exit /b
