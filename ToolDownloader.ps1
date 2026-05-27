# List of URLs to download
 $urls = @(
    "https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe",
    "https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe",
    "https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe",
    "https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe",
    "https://github.com/horsicq/DIE-engine/releases/download/3.09/die_win64_portable_3.09_x64.zip",
    "https://www.nirsoft.net/utils/winprefetchview.zip",
    "https://www.nirsoft.net/utils/userassistview.zip",
    "https://www.nirsoft.net/utils/taskschedulerview.zip",
    "https://www.nirsoft.net/utils/computeractivityview.zip"
)

# Define the destination folder
 $destination = "C:\SS"

# Check if the folder exists, if not, create it
if (!(Test-Path -Path $destination)) {
    Write-Host "Creating folder: $destination" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $destination | Out-Null
}

# Loop through each URL and download
foreach ($url in $urls) {
    # Extract the file name from the URL
    $fileName = Split-Path $url -Leaf
    
    # Combine the destination folder and file name to get the full path
    $outputPath = Join-Path -Path $destination -ChildPath $fileName
    
    Write-Host "Downloading $fileName to $destination..." -ForegroundColor Cyan
    
    try {
        # Download the file to the specific path
        Invoke-WebRequest -Uri $url -OutFile $outputPath
        Write-Host "Success: $fileName" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to download $fileName" -ForegroundColor Red
    }
}

Write-Host "All downloads finished." -ForegroundColor Yellow
