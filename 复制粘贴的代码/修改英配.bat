@echo off
setlocal enabledelayedexpansion

REM 默认的Destiny 2安装路径
set "DEFAULT_DESTINY2_INSTALL_PATH=D:\Steam\steamapps\common\Destiny 2"

REM 检查是否传入了命令行参数
if "%~1" == "" (
    REM 提示用户输入Destiny 2的安装路径
    set /p "DESTINY2_INSTALL_PATH=请输入Destiny 2的安装路径 ,回车即为D盘默认路径[%DEFAULT_DESTINY2_INSTALL_PATH%]: "
    REM 如果用户没有输入路径，则使用默认路径
    if "!DESTINY2_INSTALL_PATH!" == "" set "DESTINY2_INSTALL_PATH=%DEFAULT_DESTINY2_INSTALL_PATH%"
) else (
    REM 使用用户提供的安装路径
    set "DESTINY2_INSTALL_PATH=%~1"
)

REM 检查输入的安装路径是否存在
if not exist "%DESTINY2_INSTALL_PATH%" (
    echo 输入的Destiny 2安装路径不存在：%DESTINY2_INSTALL_PATH%
    pause
    exit /b 1
)

REM 设置临时文件夹路径
set "TEMP_DIR=C:\Destiny2Temp"

REM 创建临时文件夹
if not exist "%TEMP_DIR%" (
    mkdir "%TEMP_DIR%"
    if errorlevel 1 (
        echo 创建临时文件夹失败：%TEMP_DIR%
        pause
        exit /b 1
    )
)

REM 复制并重命名文件到临时文件夹
for /r "%DESTINY2_INSTALL_PATH%\packages" %%F in (*_en_*.pkg) do (
    set "SRC_FILE=%%F"
    set "SRC_FILENAME=%%~nF"
    set "EXTENSION=%%~xF"
    set "NEW_FILENAME=!SRC_FILENAME:_en_=_cs_!!EXTENSION!"
    echo 复制 "%%F" 到 "%TEMP_DIR%\!NEW_FILENAME!"
    copy "%%F" "%TEMP_DIR%\!NEW_FILENAME!" > nul
)

REM 将临时文件夹中的文件复制并覆盖到Destiny 2安装目录的packages文件夹
xcopy /s /y "%TEMP_DIR%\*" "%DESTINY2_INSTALL_PATH%\packages\"

REM 删除临时文件夹中的文件
del /s /q "%TEMP_DIR%\*"

REM 删除临时文件夹
rmdir /s /q "%TEMP_DIR%"

REM 删除cache文件
for /r "%DESTINY2_INSTALL_PATH%" %%H in (cache*.dat) do (
    del "%%H" /q > nul
)

echo 操作完成。
pause
exit /b 0
