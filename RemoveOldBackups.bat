@echo off

:: Read BackupDir from ini file
for /f "delims=" %%i in ('ini.bat config.ini Config BackupDir') do set BackupDir=%%i

if NOT EXIST %BackupDir% (
	echo The backup dir %BackupDir% specified in config.ini does not exist !
	exit /b
)

echo This script will remove backups from the backup directory
echo %BackupDir%
echo If this is incorrect, then please fix your ini file
echo ---------------------------------------------------
echo Please specify the age of the files that should be removed using the following format:
echo [weeks]W[days]D[hours]h[minutes]m[seconds]s
echo or [number of latest backups that should be KEPT
echo examples:
echo  * Remove all backups from ..
echo    .. 2 weeks ago: 2W
echo    .. 3 days, 16 minutes ago: 3D16m
echo  * Keep last 20 backups: 20B

set /p INTERVAL="Please enter: " %=%

rdiff-backup --force --remove-older-than %INTERVAL% %BackupDir%

pause