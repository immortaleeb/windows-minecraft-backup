@echo off

:: Read BackupDir and ServerDir from ini file
for /f "delims=" %%i in ('ini.bat config.ini Config BackupDir') do set BackupDir=%%i
for /f "delims=" %%i in ('ini.bat config.ini Config ServerDir') do set ServerDir=%%i
for /f "delims=" %%i in ('ini.bat config.ini Config WorldName') do set WorldName=%%i

if NOT EXIST %BackupDir% (
	echo The backup dir %BackupDir% specified in config.ini does not exist !
	exit /b
)

if NOT EXIST %ServerDir% (
	echo The server dir %ServerDir% specified in config.ini does not exist !
	exit /b
)

if NOT EXIST %ServerDir%\%WorldName% (
	echo The world dir %WorldName% specified in config.ini does not exist !
	exit /b
)

echo This will restore a backup of world "%WorldName%" from directory
echo %BackupDir%
echo to directory
echo %ServerDir%\%WorldName%
echo If this is not correct, enter an invalid number and your ini file
echo --------------------------------------------------------------------
echo Please select one of the following
echo  1. Restore latest backup
echo  2. Restore backup X days,hours,minutes and seconds ago
echo  3. Restore backup from specific date and time
set /p CHOICE="Your answer: " %=%

call :CASE_%CHOICE%
IF errorlevel 1 call :DEFAULT_CASE

exit /b

:CASE_1
	rdiff-backup --force --restore-as-of now %BackupDir% %ServerDir%\%WorldName%
	goto END_CASE
:CASE_2
	echo Please enter the interval in the format shown below:
	echo [days]D[hours]h[minutes]m[seconds]s
	echo Example: 10 days, 5 minutes ago = 10D5m
	echo Example: 30 minutes ago: 30m
	echo Example: 1 day, 2 hours, 16 minutes, 4 seconds ago: 1D2h16m4s
	
	goto ENTER_CASE
:CASE_3
	echo Please enter the exact moment in the format shown below:
	echo 2002-01-25T07:00:00+02:00 (YYYY-MM-DDTHH:mm:ss)
	echo The +02:00 means time zone 2 hours ahead of UTC 
	echo If the time zone is ommited, the systems regional settings will be used
:ENTER_CASE
	set /p INTERVAL="Please enter: " %=%
	
	rdiff-backup --force  -r %INTERVAL% %BackupDir% %ServerDir%\%WorldName%

	goto END_CASE
:DEFAULT_CASE
	echo Either the backup failed, or you entered a wrong number...
	echo Either way: something failed! Now go fix it for me!
	goto :EOF
:END_CASE
	if errorlevel 0 echo Backup restored succesfully
	pause
	goto :EOF