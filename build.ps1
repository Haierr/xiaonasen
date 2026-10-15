[CmdletBinding()]
param([string]$OutputDirectory = (Join-Path $PSScriptRoot 'dist'))
$ErrorActionPreference = 'Stop'
$compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
$speech = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\WPF\System.Speech.dll'
foreach ($dependency in @($compiler,$speech)) {if (!(Test-Path -LiteralPath $dependency)) {throw "Install .NET Framework 4.8 x64. Missing: $dependency"}}
$destination = [IO.Path]::GetFullPath($OutputDirectory)
New-Item -ItemType Directory -Path $destination -Force | Out-Null
# Small native WebRTC speech detector, pinned and verified; no managed NuGet runtime.
$vadCache = Join-Path $PSScriptRoot 'work\vad-1.3.2'
New-Item -ItemType Directory -Path $vadCache -Force | Out-Null
$vadArchive = Join-Path $vadCache 'package.zip'
$vadHash = '61e28bb086f1e80b1171999da0b3ca71451353cde42b8029455653eec264fcce'
if (!(Test-Path -LiteralPath $vadArchive)) {Invoke-WebRequest -UseBasicParsing -Uri 'https://api.nuget.org/v3-flatcontainer/webrtcvadsharp/1.3.2/webrtcvadsharp.1.3.2.nupkg' -OutFile $vadArchive}
if ((Get-FileHash -LiteralPath $vadArchive -Algorithm SHA256).Hash.ToLowerInvariant() -ne $vadHash) {throw 'VAD package checksum mismatch'}
Expand-Archive -LiteralPath $vadArchive -DestinationPath (Join-Path $vadCache 'package') -Force
$vadLibrary = Join-Path $vadCache 'package\build\win-x64\native\WebRtcVad.dll'
if ((Get-FileHash -LiteralPath $vadLibrary -Algorithm SHA256).Hash.ToLowerInvariant() -ne 'bcbb4b85172614de8110e109931628fa29e2e23b9c631921c8d0afd4a8df13f6') {throw 'VAD library checksum mismatch'}
Copy-Item -LiteralPath $vadLibrary -Destination (Join-Path $destination 'WebRtcVad.dll') -Force
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'tests\fixtures\speech-16k.raw') -Destination (Join-Path $destination 'speech-test.raw') -Force
$binary = Join-Path $destination 'xiaonasen.exe'
$source = Join-Path $PSScriptRoot 'src\SaymoreLite.cs'
$icon = Join-Path $PSScriptRoot 'assets\coffee.ico'
& $compiler /nologo /target:winexe /platform:x64 /optimize+ /codepage:65001 /win32icon:$icon /out:$binary /r:System.Drawing.dll /r:System.Windows.Forms.dll /r:System.Web.Extensions.dll /r:System.Net.Http.dll /r:$speech $source
if ($LASTEXITCODE -ne 0) {throw 'Build failed'}
foreach ($file in @('coffee-logo.png','coffee.ico','coffee-prompt.txt','hero.svg')) {Copy-Item -LiteralPath (Join-Path $PSScriptRoot ('assets\'+$file)) -Destination (Join-Path $destination $file) -Force}
# Preserve a user's customized vocabulary on rebuild.
if (!(Test-Path -LiteralPath (Join-Path $destination 'terms.txt'))) {Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'defaults\terms.txt') -Destination (Join-Path $destination 'terms.txt')}
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'defaults\settings.example.json') -Destination (Join-Path $destination 'settings.example.json') -Force
foreach ($file in @('README.md','README.en.md','LICENSE','THIRD_PARTY_NOTICES.md','THIRD_PARTY_NOTICES.en.md','SECURITY.md','SECURITY.en.md','CHANGELOG.md')) {Copy-Item -LiteralPath (Join-Path $PSScriptRoot $file) -Destination (Join-Path $destination $file) -Force}
Write-Output "Built: $binary"
