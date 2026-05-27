# Clear the console to start fresh
Clear-Host

# --- Start Header ---
Write-Host "NicToolDownloader" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host ""

# --- Configuration ---
 $downloadDir = "C:\SS"

# Create the directory if it does not exist
if (!(Test-Path -Path $downloadDir)) {
    try {
        New-Item -ItemType Directory -Path $downloadDir -Force | Out-Null
        Write-Host "[INFO] Created directory at $downloadDir" -ForegroundColor Green
    }
    catch {
        Write-Host "[ERROR] Failed to create directory. Please check permissions." -ForegroundColor Red
        exit
    }
}
else {
    Write-Host "[INFO] Directory already exists at $downloadDir" -ForegroundColor Gray
}
Write-Host ""

# --- Download Links ---
 $urls = @(
    "https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe",
    "https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe",
    "https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe",
    "https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe"
)

# --- Download Loop ---
Write-Host "[START] Downloading files..." -ForegroundColor Cyan
Write-Host ""

foreach ($url in $urls) {
    # Extract the file name from the URL
    $fileName = Split-Path $url -Leaf
    $destination = Join-Path -Path $downloadDir -ChildPath $fileName

    Write-Host "Downloading $fileName..." -NoNewline
    
    try {
        # Use Invoke-WebRequest to download the file
        Invoke-WebRequest -Uri $url -OutFile $destination -UseBasicParsing
        Write-Host " [DONE]" -ForegroundColor Green
    }
    catch {
        Write-Host " [FAILED]" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor DarkRed
    }
}

Write-Host ""
Write-Host "[FINISH] All tasks completed." -ForegroundColor Cyan
Write-Host ""

# --- End Footer ---
# Define the separator variable used in your footer code
 $sumSep = "=" * 40

Write-Host "  Created by  : " -NoNewline -ForegroundColor DarkGray
Write-Host "cheese cat" -ForegroundColor Yellow
Write-Host "  Discord     : " -NoNewline -ForegroundColor DarkGray
Write-Host "cheese_cat0" -ForegroundColor Yellow
Write-Host "  GitHub      : " -NoNewline -ForegroundColor DarkGray
Write-Host "github.com/cheesecatlol" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Created by  : " -NoNewline -ForegroundColor DarkGray
Write-Host "nic" -ForegroundColor Yellow
Write-Host "  Discord     : " -NoNewline -ForegroundColor DarkGray
Write-Host "mecz.exe" -ForegroundColor Yellow
Write-Host "  GitHub      : " -NoNewline -ForegroundColor DarkGray
Write-Host "github.com/Nickk196" -ForegroundColor Yellow
Write-Host ""
Write-Host $sumSep -ForegroundColor DarkYellow
Write-Host ""
Read-Host "  Press Enter to exit"
