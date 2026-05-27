<# :
@echo off
setlocal
set "POWERSHELL_BAT_ARGS=%*"
if defined POWERSHELL_BAT_ARGS set "POWERSHELL_BAT_ARGS=%POWERSHELL_BAT_ARGS:\"=\"%"
endlocal & powershell -NoProfile -ExecutionPolicy Bypass -Command "& { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; $input | &([ScriptBlock]::Create((Get-Content \"%~f0\" -Raw))) }" %POWERSHELL_BAT_ARGS%
exit /b
#>

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
        Read-Host "Press Enter to exit"
        exit
    }
}
else {
    Write-Host "[INFO] Directory already exists at $downloadDir" -ForegroundColor Gray
}
Write-Host ""

# --- Automatic System Informer Logic ---
Write-Host "[AUTO] Searching for latest System Informer version..." -ForegroundColor Cyan
 $siUrl = $null
try {
    # Query GitHub API for the latest release
    $apiUrl = "https://api.github.com/repos/winsiderss/systeminformer/releases"
    $response = Invoke-RestMethod -Uri $apiUrl -Headers @{"Accept"="application/vnd.github.v3+json"} -ErrorAction Stop
    
    # Get the first (latest) release
    $latestRelease = $response[0]
    
    # Find the setup asset (looking for -setup.exe)
    $asset = $latestRelease.assets | Where-Object { $_.name -match "systeminformer-.*-setup\.exe" } | Select-Object -First 1
    
    if ($asset) {
        $siUrl = $asset.browser_download_url
        Write-Host "[AUTO] Found Latest: $($asset.name)" -ForegroundColor Green
    }
    else {
        Write-Host "[WARN] Could not find setup file in latest release." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "[WARN] Failed to fetch from GitHub API (Network/Rate-Limit)." -ForegroundColor Yellow
}

# Fallback to a known recent version if Auto-Detect failed
if (-not $siUrl) {
    Write-Host "[FALLBACK] Using specific System Informer version." -ForegroundColor DarkGray
    $siUrl = "https://github.com/winsiderss/systeminformer/releases/download/v4.0.26144/systeminformer-4.0.26144-setup.exe"
}

# --- Download Links ---
 $urls = @(
    "https://github.com/Orbdiff/SSTool/releases/download/yay/SSTool.exe",
    "https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/download/V.1.2/MeowDoomsdayFucker.exe",
    "https://github.com/MeowTonynoh/MeowImportsChecker/releases/download/MeowImportsChecker/MeowImportsChecker.exe",
    "https://github.com/MeowTonynoh/MeowResolver/releases/download/MeowResolver/MeowResolver.exe",
    $siUrl, # This will use the auto-detected or fallback link
    "https://www.nirsoft.net/utils/winprefetchview.zip"
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
        
        # --- EXTRACTION REMOVED PER REQUEST ---
        # Files (including zips) will remain in their original format.
        
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
