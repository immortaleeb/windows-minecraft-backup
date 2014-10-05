## Backup scripts for minecraft servers running on a Windows machine
This repository contains a few backup scripts that can be used to automatically take backups of a running minecraft server on a windows machine.

## Requirements (aka don't try anything before you have read this first)
In order to be able to use these scripts, you will need to have the following things installed/configured:

### Windows
All scripts are written in either batch or AutoHotkey and are intended to be run on a windows machine.

### AutoHotkey (http://www.autohotkey.com/)
The main start script (StartServer.ahk) is written in AutoHotkey and contains all functionality for starting the server, printing messages and delegating commands to the appropriate scripts. Suffice to say you will need AutoHotkey if you want to do automatic backups.

### rdiff-backup (http://www.nongnu.org/rdiff-backup/)
The scripts in this repository make use of rdiff-backup to perform the actual backup. Make sure that it is accessible in your PATH variable, so that the rdiff-backup command can easily be executed from the command prompt.

## Overview (aka what is each file's purpose?)
#### StartServer.ahk
Use this script to start up your minecraft server. Depending on your configuration, it should start your minecraft server and take periodic backups for as long as your server is running. Once your server quits, this script should stop executing aswel.

#### StartServer.bat
This batch file contains the commands necessary to execute your minecraft server. If you want to start your server with additional arguments (like increasing the amount of RAM your java can use) you should edit this file.

#### BackupWorld.bat
This batch files contains the commands that will be used to backup your minecraft server, only make changes if you know what you're doing!

#### RemoveOldBackups.bat
A more-user friendly way than using plain rdiff-backup commands to remove older backups.

#### RestoreBackup.bat
A more user-friendly way then using plain rdiff-backup commands to restore an older backup.

#### ini.bat
Just a utility batch script that is used to read configuration settings from config.ini.

#### config.ini
The main configuration file, make sure to read the comments above each key; They should explain what each key means.
