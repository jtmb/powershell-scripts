# /////////////////////VARS ///////////////////////
$BackupDir = "G:\backups\WSL" #set backup location
$US_InsideOut = 'MM-dd-yyyy' #set time format to var
$date = Get-Date -Format $US_InsideOut #Set VAR for date using $US_InsideOut format
# /////////////////////////////////////////////////

#Export WSL (backup)
cd $BackupDir
wsl --export 
Ubuntu wsl_ubuntu_backup_$date.tar
