[CmdletBinding()]
param([string]$AppDirectory = (Join-Path $PSScriptRoot '..\dist'),[string]$OutputDirectory = (Join-Path $PSScriptRoot '..\artifacts'))
$ErrorActionPreference = 'Stop'
$root = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$app = [IO.Path]::GetFullPath($AppDirectory)
$output = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Path $output -Force | Out-Null
$version = (Get-Item -LiteralPath (Join-Path $app 'xiaonasen.exe')).VersionInfo.FileVersion
$version = ($version.Split('.')[0..2] -join '.')
$name = "xiaonasen-$version-windows-x64"
$staging = Join-Path $output ($name+'-staging-'+[Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $staging -Force | Out-Null
# Explicit allowlist: never package personal settings, test text, logs or models.
foreach ($file in @('xiaonasen.exe','coffee-logo.png','coffee.ico','coffee-prompt.txt','hero.svg','settings.example.json','README.md','README.en.md','LICENSE','THIRD_PARTY_NOTICES.md','THIRD_PARTY_NOTICES.en.md','SECURITY.md','SECURITY.en.md','CHANGELOG.md')) {Copy-Item -LiteralPath (Join-Path $app $file) -Destination (Join-Path $staging $file)}
foreach ($guide in @('CONTRIBUTING.md','CONTRIBUTING.en.md')) {Copy-Item -LiteralPath (Join-Path $root $guide) -Destination (Join-Path $staging $guide)}
foreach ($languageReadme in @('README.md','README.en.md')) {
    $readme = Join-Path $staging $languageReadme
    $portableReadme = [IO.File]::ReadAllText($readme).Replace('assets/coffee-logo.png','coffee-logo.png').Replace('assets/coffee-prompt.txt','coffee-prompt.txt').Replace('assets/hero.svg','hero.svg')
    [IO.File]::WriteAllText($readme,$portableReadme,[Text.UTF8Encoding]::new($false))
}
Copy-Item -LiteralPath (Join-Path $root 'defaults\terms.txt') -Destination (Join-Path $staging 'terms.txt')
Copy-Item -LiteralPath (Join-Path $root 'runtime-manifest.json') -Destination (Join-Path $staging 'runtime-manifest.json')
Copy-Item -LiteralPath (Join-Path $root 'scripts\setup-runtime.ps1') -Destination (Join-Path $staging 'setup-runtime.ps1')
foreach ($folder in @('docs','licenses')) {Copy-Item -LiteralPath (Join-Path $root $folder) -Destination (Join-Path $staging $folder) -Recurse}
$archive = Join-Path $output ($name+'.zip')
Compress-Archive -Path (Join-Path $staging '*') -DestinationPath $archive -Force
$hash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant()
"$hash  $name.zip" | Set-Content -LiteralPath (Join-Path $output 'SHA256SUMS.txt') -Encoding ASCII
Write-Output $archive
