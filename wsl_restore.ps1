# /////////////////////VARS ///////////////////////
$folderPath = "G:\backups\WSL" #set backup location
$files = Get-ChildItem -Path $folderPath -File # Get the files in the folder
# /////////////////////////////////////////////////

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
} else {
    # Output an error message if the user input is invalid
    Write-Host "Invalid selection. Please enter a number between 0 and $($files.Count - 1)." -ForegroundColor Red
}

# Import Selected Backup
wsl --import Ubuntu c:\wsl $folderPath\$selectedFile