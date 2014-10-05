@echo off

SET ServerDir=%1
SET World=%2
SET BackupDir=%3

IF NOT EXIST %BackupDir% mkdir %BackupDir%

rdiff-backup %ServerDir%\%World% %BackupDir%