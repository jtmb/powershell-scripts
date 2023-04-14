# ///////////////////// VARS ///////////////////////
    $folderPath = "G:\backups\WSL" #set backup location
    $files = Get-ChildItem -Path $folderPath -File # Get the files in the folder
# /////////////////////////////////////////////////


# ///////////////////// WSL RESTORE ///////////////////////
# Enable WSL
WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# install wsl
wsl --install
# Display the files in a numbered list
Write-Host "Files in folder:" -ForegroundColor Yellow
for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host "$i. $($files[$i].Name)"
}
# Ask the user to select a file
$fileIndex = Read-Host "Enter the number of the file to select"

# Check if the user input is valid
if ($fileIndex -ge 0 -and $fileIndex -lt $files.Count) {
    # Get the selected file
    $selectedFile = $files[$fileIndex]

    # Output the selected file
    Write-Host "Selected file: $($selectedFile.FullName)" -ForegroundColor Green
    # Import Selected Backup
    wsl --import Ubuntu c:\wsl $folderPath\$selectedFile

} else {
    # Output an error message if the user input is invalid
    Write-Host "Invalid selection. Please enter a number between 0 and $($files.Count - 1)." -ForegroundColor Red
}



# ///////////////////// Defender Config///////////////////////
# update defender
Update-MpSignature
# exclude steam folders from real time scanning (fixes stuttering in some games)
Set-MpPreference -ExclusionPath D:\SteamLibrary
Set-MpPreference -ExclusionPath E:\SteamLibrary
# Run quick scan
MpScan -ScanType QuickScan



# ///////////////////// Power Plan Settings ///////////////////////

# Set power Plan to high performance
$p = Get-CimInstance -Name root\cimv2\power -Class win32_PowerPlan -Filter "ElementName = 'High Performance'"      
powercfg /setactive ([string]$p.InstanceID).Replace("Microsoft:PowerPlan\{","").Replace("}","")


# ///////////////////// Package settings ///////////////////////

$url = "https://ninite.com/chrome-WinRAR-discord-steam-windirstat-vlc-audacity-spotify-vscode-gimp-qbittorrent/ninite.exe"
$output = "C:\Scripts\ninite.exe"
 
# Creates Scripts directory in the root of C:
New-Item C:\Scripts\ -ItemType Directory
 
# Calls upon Ninite URL to grab .exe
Invoke-WebRequest -Uri $url -OutFile $output
 
# Starts Ninite.exe
Start-Process -FilePath "C:\Scripts\ninite.exe"

# kill the onedrive prcess
taskkill /f /im OneDrive.exe

# uninstall onedrive
cmd -c "%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall"


# Nvidia Driver Settings
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
# Execute Nvidia Install Script
.\scripts\nvidia.ps1