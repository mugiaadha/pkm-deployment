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
xcopy "!old_name!" "./result/!new_name!" /E /I /H /Y >nul

:: === FILE REPLACEMENT ===
for /f "usebackq delims=" %%f in ("file-list.txt") do (
  set "filepath=./result/!new_name!\clenic\%%~f"
  call :replacefile "!filepath!" "!old_db!" "!new_db!" "!old_code!" "!new_code!"
)

:: === CEK DENGAN CURL ===
echo.
echo Checking branch [!new_code!]...
curl -s https://emr.clenicapp.com/api/master-data/cabang/!new_code! > tmp-response.txt

findstr /C:"\"success\":true" tmp-response.txt >nul
if !errorlevel! == 0 (
  echo SUCCESS: Branch !new_code! aktif!
  ) else (
  echo FAILED: Branch !new_code! tidak ditemukan!
)

del tmp-response.txt

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
