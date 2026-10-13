[CmdletBinding()]
param([string]$AppDirectory,[string]$SourceRuntime,[switch]$SkipModels,[switch]$VerifyOnly)
$ErrorActionPreference = 'Stop'
if (!$AppDirectory) {$AppDirectory = if(Test-Path -LiteralPath (Join-Path $PSScriptRoot 'runtime-manifest.json')){$PSScriptRoot}else{Join-Path $PSScriptRoot '..\dist'}}
$manifestPath = if(Test-Path -LiteralPath (Join-Path $PSScriptRoot 'runtime-manifest.json')){Join-Path $PSScriptRoot 'runtime-manifest.json'}else{Join-Path $PSScriptRoot '..\runtime-manifest.json'}
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$app = [IO.Path]::GetFullPath($AppDirectory)
$runtime = Join-Path $app 'runtime'
function ResourcePath([string]$relative) {
    $path = [IO.Path]::GetFullPath((Join-Path $runtime $relative))
    if (!$path.StartsWith($runtime+[IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase)) {throw 'Resource path outside runtime directory'}
    return $path
}
function Matches([string]$path,[string[]]$hashes) {return (Test-Path -LiteralPath $path -PathType Leaf) -and ((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() -in $hashes)}
function Fetch([string]$url,[string]$destination,[string[]]$hashes) {
    if (Matches $destination $hashes) {Write-Output "Verified existing: $destination";return}
    New-Item -ItemType Directory -Path (Split-Path -Parent $destination) -Force | Out-Null
    $partial = $destination+'.part'
    Write-Output "Downloading: $url"
    & curl.exe --fail --location --retry 3 --connect-timeout 20 --continue-at - --output $partial $url
    if ($LASTEXITCODE -ne 0) {throw "Download failed; resume by running this script again: $url"}
    if (!(Matches $partial $hashes)) {throw "SHA-256 mismatch. Resource left uninstalled: $partial"}
    Move-Item -LiteralPath $partial -Destination $destination -Force
}
if ($SourceRuntime) {
    if ($VerifyOnly) {throw 'Choose SourceRuntime or VerifyOnly, not both'}
    $source = [IO.Path]::GetFullPath($SourceRuntime)
    if ($source.TrimEnd('\') -eq $runtime.TrimEnd('\')) {throw 'Source and target runtime must differ'}
    New-Item -ItemType Directory -Path $runtime -Force | Out-Null
    foreach ($folder in @('llama-cpp','polish_lora','models')) {
        if ($SkipModels -and $folder -eq 'models') {continue}
        $origin = Join-Path $source $folder
        if (!(Test-Path -LiteralPath $origin -PathType Container)) {throw "Missing source directory: $origin"}
        $target = ResourcePath $folder
        New-Item -ItemType Directory -Path $target -Force | Out-Null
        Get-ChildItem -LiteralPath $origin -Force | ForEach-Object {Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force}
    }
} elseif (!$VerifyOnly) {
    if (!(Get-Command curl.exe -ErrorAction SilentlyContinue)) {throw 'Windows curl.exe is required'}
    $engine = ResourcePath 'llama-cpp\llama-server.exe'
    if (!(Matches $engine @($manifest.engine.serverSha256))) {
        $archive = ResourcePath '.downloads\llama-vulkan-b10034.zip'
        Fetch $manifest.engine.url $archive @($manifest.engine.sha256)
        $unpack = ResourcePath ('.downloads\unpack-'+[Guid]::NewGuid().ToString('N'))
        Expand-Archive -LiteralPath $archive -DestinationPath $unpack
        $server = Get-ChildItem -LiteralPath $unpack -Filter 'llama-server.exe' -Recurse | Select-Object -First 1
        if (!$server -or !(Matches $server.FullName @($manifest.engine.serverSha256))) {throw 'Engine executable verification failed'}
        $target = ResourcePath 'llama-cpp'
        New-Item -ItemType Directory -Path $target -Force | Out-Null
        Get-ChildItem -LiteralPath $server.DirectoryName -File | ForEach-Object {Copy-Item -LiteralPath $_.FullName -Destination $target -Force}
    }
    foreach ($file in $manifest.files) {if (!$SkipModels -or !$file.model) {Fetch $file.url (ResourcePath $file.path) $file.sha256}}
}
$missing = @()
if (!(Matches (ResourcePath 'llama-cpp\llama-server.exe') @($manifest.engine.serverSha256))) {$missing += 'llama-server.exe'}
foreach ($dll in @('llama.dll','ggml.dll','ggml-base.dll','mtmd.dll','ggml-vulkan.dll')) {if (!(Test-Path -LiteralPath (ResourcePath ('llama-cpp\'+$dll)))) {$missing += $dll}}
foreach ($file in $manifest.files) {if ((!$SkipModels -or !$file.model) -and !(Matches (ResourcePath $file.path) $file.sha256)) {$missing += $file.path}}
if ($missing.Count) {throw ('Runtime missing or invalid: '+($missing -join ', '))}
if (!$VerifyOnly) {
    New-Item -ItemType Directory -Path (ResourcePath 'licenses') -Force | Out-Null
    $licenseRoot = if(Test-Path -LiteralPath (Join-Path $PSScriptRoot 'licenses')){Join-Path $PSScriptRoot 'licenses'}else{Join-Path $PSScriptRoot '..\licenses'}
    Get-ChildItem -LiteralPath $licenseRoot -File | ForEach-Object {Copy-Item -LiteralPath $_.FullName -Destination (ResourcePath ('licenses\'+$_.Name)) -Force}
}
if ($SkipModels) {Write-Output 'Engine and text resources verified. ASR models were explicitly skipped.'}else{Write-Output "Runtime ready: $runtime"}
