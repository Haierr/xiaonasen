[CmdletBinding()]
param([string]$OutputDirectory = (Join-Path $PSScriptRoot 'dist'))
$ErrorActionPreference = 'Stop'
$compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
$speech = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\WPF\System.Speech.dll'
foreach ($dependency in @($compiler,$speech)) {if (!(Test-Path -LiteralPath $dependency)) {throw "Install .NET Framework 4.8 x64. Missing: $dependency"}}
$destination = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Path $destination -Force | Out-Null
$binary = Join-Path $destination 'xiaonasen.exe'
$source = Join-Path $PSScriptRoot 'src\SaymoreLite.cs'
$icon = Join-Path $PSScriptRoot 'assets\coffee.ico'
& $compiler /nologo /target:winexe /platform:x64 /optimize+ /codepage:65001 /win32icon:$icon /out:$binary /r:System.Drawing.dll /r:System.Windows.Forms.dll /r:System.Web.Extensions.dll /r:System.Net.Http.dll /r:$speech $source
if ($LASTEXITCODE -ne 0) {throw 'Build failed'}
foreach ($file in @('coffee-logo.png','coffee.ico','coffee-prompt.txt')) {Copy-Item -LiteralPath (Join-Path $PSScriptRoot ('assets\'+$file)) -Destination (Join-Path $destination $file) -Force}
# Preserve a user's customized vocabulary on rebuild.
if (!(Test-Path -LiteralPath (Join-Path $destination 'terms.txt'))) {Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'defaults\terms.txt') -Destination (Join-Path $destination 'terms.txt')}
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'defaults\settings.example.json') -Destination (Join-Path $destination 'settings.example.json') -Force
foreach ($file in @('README.md','LICENSE','THIRD_PARTY_NOTICES.md','CHANGELOG.md')) {Copy-Item -LiteralPath (Join-Path $PSScriptRoot $file) -Destination (Join-Path $destination $file) -Force}
Write-Output "Built: $binary"
