@echo off
setlocal enabledelayedexpansion

REM Ĭ�ϵ�Destiny 2��װ·��
set "DEFAULT_DESTINY2_INSTALL_PATH=D:\Steam\steamapps\common\Destiny 2"

REM ����Ƿ����������в���
if "%~1" == "" (
    REM ��ʾ�û�����Destiny 2�İ�װ·��
    set /p "DESTINY2_INSTALL_PATH=������Destiny 2�İ�װ·�� ,�س���ΪD��Ĭ��·��[%DEFAULT_DESTINY2_INSTALL_PATH%]: "
    REM ����û�û������·������ʹ��Ĭ��·��
    if "!DESTINY2_INSTALL_PATH!" == "" set "DESTINY2_INSTALL_PATH=%DEFAULT_DESTINY2_INSTALL_PATH%"
) else (
    REM ʹ���û��ṩ�İ�װ·��
    set "DESTINY2_INSTALL_PATH=%~1"
)

REM �������İ�װ·���Ƿ����
if not exist "%DESTINY2_INSTALL_PATH%" (
    echo �����Destiny 2��װ·�������ڣ�%DESTINY2_INSTALL_PATH%
    pause
    exit /b 1
)

REM ������ʱ�ļ���·��
set "TEMP_DIR=C:\Destiny2Temp"

REM ������ʱ�ļ���
if not exist "%TEMP_DIR%" (
    mkdir "%TEMP_DIR%"
    if errorlevel 1 (
        echo ������ʱ�ļ���ʧ�ܣ�%TEMP_DIR%
        pause
        exit /b 1
    )
)

REM ���Ʋ��������ļ�����ʱ�ļ���
for /r "%DESTINY2_INSTALL_PATH%\packages" %%F in (*_en_*.pkg) do (
    set "SRC_FILE=%%F"
    set "SRC_FILENAME=%%~nF"
    set "EXTENSION=%%~xF"
    set "NEW_FILENAME=!SRC_FILENAME:_en_=_cs_!!EXTENSION!"
    echo ���� "%%F" �� "%TEMP_DIR%\!NEW_FILENAME!"
    copy "%%F" "%TEMP_DIR%\!NEW_FILENAME!" > nul
)

REM ����ʱ�ļ����е��ļ����Ʋ����ǵ�Destiny 2��װĿ¼��packages�ļ���
xcopy /s /y "%TEMP_DIR%\*" "%DESTINY2_INSTALL_PATH%\packages\"

REM ɾ����ʱ�ļ����е��ļ�
del /s /q "%TEMP_DIR%\*"

REM ɾ����ʱ�ļ���
rmdir /s /q "%TEMP_DIR%"

REM ɾ��cache�ļ�
for /r "%DESTINY2_INSTALL_PATH%" %%H in (cache*.dat) do (
    del "%%H" /q > nul
)

echo ������ɡ�
pause
exit /b 0
