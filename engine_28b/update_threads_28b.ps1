# update_threads_28b.ps1
# Auto-run benchmark for 28B model, extract recommended numSearchThreads

$ScriptDir = $PSScriptRoot
if (-not $ScriptDir) { $ScriptDir = "." }

$KataGoExe = Join-Path $ScriptDir "katago.exe"
$ModelFile = "kata1-zhizi-b28c512nbt-muonfd2.bin.gz"
$ConfigFile = Join-Path $ScriptDir "default_gtp.cfg"
$TempOutput = Join-Path $ScriptDir "benchmark_output.txt"

# Check if katago.exe exists
if (-not (Test-Path $KataGoExe)) {
    Write-Host "ERROR: katago.exe not found in script directory!" -ForegroundColor Red
    exit 1
}

# ====== 新增：自动去除配置文件的 BOM ======
if (Test-Path $ConfigFile) {
    $content = Get-Content $ConfigFile -Raw -Encoding UTF8
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($ConfigFile, $content, $utf8NoBom)
    Write-Host "Removed BOM from $ConfigFile (if any)." -ForegroundColor DarkGray
}
# =========================================

Write-Host "Running benchmark for 28B model, please wait..." -ForegroundColor Cyan

# Run benchmark, display progress in real-time, and save output to file
& $KataGoExe benchmark -model $ModelFile 2>&1 | ForEach-Object {
    Write-Host $_
    $_ | Out-File -FilePath $TempOutput -Append -Encoding UTF8
}

# Extract recommended numSearchThreads
$lines = Get-Content $TempOutput -Encoding UTF8
$recommended = $null
foreach ($line in $lines) {
    if ($line -match 'numSearchThreads\s*=\s*(\d+).*\(recommended\)') {
        $recommended = [int]$Matches[1]
        break
    }
}

Remove-Item $TempOutput -ErrorAction SilentlyContinue

if ($recommended -eq $null) {
    Write-Host "ERROR: Could not find recommended value in benchmark output!" -ForegroundColor Red
    exit 1
}

Write-Host "Recommended numSearchThreads for 28B = $recommended" -ForegroundColor Green

# Update config file
if (-not (Test-Path $ConfigFile)) {
    Write-Host "ERROR: Config file $ConfigFile not found!" -ForegroundColor Red
    exit 1
}

$configContent = Get-Content $ConfigFile -Encoding UTF8
$found = $false
$newContent = @()
foreach ($line in $configContent) {
    if ($line -match '^\s*numSearchThreads\s*=') {
        $newContent += "numSearchThreads = $recommended"
        $found = $true
    } else {
        $newContent += $line
    }
}

if (-not $found) {
    $newContent += "`nnumSearchThreads = $recommended"
}

# Backup original
Copy-Item $ConfigFile "$ConfigFile.bak" -Force

# Write file WITHOUT BOM using .NET
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllLines($ConfigFile, $newContent, $utf8NoBom)

Write-Host "Config file updated! Original backed up as $ConfigFile.bak" -ForegroundColor Green