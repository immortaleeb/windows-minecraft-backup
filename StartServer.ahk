; Ini file which contains the configs
IniFile = config.ini

SetWorkingDir %A_ScriptDir%

; Read Ini file
IniRead, ServerDir, %IniFile%, Config, ServerDir,
IniRead, ServerJar, %IniFile%, Config, ServerJar, minecraft.jar
IniRead, WorldName, %IniFile%, Config, WorldName, world
IniRead, BackupDir, %IniFile%, Config, BackupDir,
IniRead, SavePeriod, %IniFile%, Config, SavePeriod, 30

ServerDir := """" . ServerDir . """"
BackupDir := """" . BackupDir . """"

SetTitleMatchMode, 3

RunWait, % "StartServer.bat " . ServerDir . " " . ServerJar . " " . WorldName, % ServerDir

Sleep, 60000

CycleStart:

IfWinNotExist, %WorldName%
{
return
}

ControlSend,, say Backup starting in 10 seconds...{Enter}, %WorldName%
Sleep, 10000

IfWinNotExist, %WorldName%
{
return
}

ControlSend,, say Backup starting! server going read-only...{Enter}, %WorldName%

ControlSend,, save-off{Enter}, %WorldName%
Sleep, 500

ControlSend,, save-all{Enter}, %WorldName%
Sleep, 5000

RunWait, % ".\BackupWorld.bat " . ServerDir . " " . WorldName . " " . BackupDir, % ServerDir, Hide
Sleep, 1000

ControlSend,, save-on{Enter}, %WorldName%
Sleep, 1000

ControlSend,, say Backup ended. server going read-write...{Enter}, %WorldName%

LoopCount := SavePeriod * 60
Loop %LoopCount%
{
Sleep, 1000
IfWinNotExist, %WorldName%
{
return
}
}

Goto, CycleStart
