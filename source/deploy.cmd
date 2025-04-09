@echo off
setlocal enabledelayedexpansion

:: === SET VARIABLE ===
set "old_name=meuraxa.clenicapp.com"
set "new_name=batoh"
set "old_db=clen_meuraxa"
set "new_db=clen_batoh"
set "old_code=183"
set "new_code=181"

:: === COPY FOLDER ===
echo Copying "%old_name%" to "%new_name%"...
xcopy "%old_name%" "%new_name%" /E /I /H /Y

:: === FILE LIST (RELATIF DARI clenic\)
for %%f in (
    "koneksi.php"
    "ws\koneksi.php"
    "api\config.php"
    "wsv2\pasien.php"
    "report\loadetiket.php"
) do (
    set "filepath=%new_name%\clenic\%%~f"
    if exist "!filepath!" (
        echo Replacing in: !filepath!
        powershell -Command "(Get-Content -Raw '!filepath!') -replace '%old_db%', '%new_db%' -replace '%old_code%', '%new_code%' | Set-Content '!filepath!'"
    ) else (
        echo File not found: !filepath!
    )
)

echo.
echo === DONE ===