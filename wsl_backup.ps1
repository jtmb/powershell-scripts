#VARS
$BackupDir = "G:\backups\WSL"
$US_InsideOut = 'MM-dd-yyyy'	
$date = Get-Date -Format $US_InsideOut

cd $BackupDir

#Export WSL (backup)
wsl --export Ubuntu wsl_ubuntu_backup_$date.tar
