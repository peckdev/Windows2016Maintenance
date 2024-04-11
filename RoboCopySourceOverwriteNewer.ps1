$source = "\\SVR-Main\ServerData" 
$destination = "\\NAS\h$\BackUps\\ServerData"
# Output header
Write-Host "--------------------------------------------------------"
Write-Host "Script created and maintained by www.PeckDevelopment.com"
Write-Host "Support at BTC bc1qw368jup8wl6uu5mfuw3vxuxw5elpqscata5c9t"
Write-Host "--------------------------------------------------------"
# Function to display progress
function Show-Progress {
    param (
        [int]$PercentComplete,
        [string]$Activity
    )
    Write-Progress -Activity $Activity -PercentComplete $PercentComplete
}

# Initialize counters
$filesCopied = 0
$filesSkipped = 0

# Copy contents of the directory to the destination directory
$files = Get-ChildItem $source
$totalFiles = $files.Count
$currentFile = 0

foreach ($file in $files) {
    $currentFile++
    $percentComplete = ($currentFile / $totalFiles) * 100
    $activity = "Copying file $($file.Name) ($currentFile of $totalFiles)"
    Show-Progress -PercentComplete $percentComplete -Activity $activity

    try {
        Copy-Item $file.FullName $destination -Force -Recurse -ErrorAction Stop -Verbose
        $filesCopied++
    } catch {
        Write-Host "Skipped file $($file.Name) because it is locked."
        $filesSkipped++
    }
}

# Display files count
Write-Host "Total files copied: $filesCopied"
Write-Host "Total files skipped: $filesSkipped"
