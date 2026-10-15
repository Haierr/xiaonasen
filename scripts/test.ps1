[CmdletBinding()]
param([string]$AppDirectory = (Join-Path $PSScriptRoot '..\dist'),[switch]$WithRuntime,[switch]$Interactive,[switch]$Stress)
$ErrorActionPreference = 'Stop'
$binary = Join-Path ([IO.Path]::GetFullPath($AppDirectory)) 'xiaonasen.exe'
if (!(Test-Path -LiteralPath $binary)) {throw 'Run build.ps1 first'}
$checks = @('--appearance-test','--compact-test','--language-key-test','--hotkey-test','--reliability-test')
if ($Interactive) {$checks += '--window-test'}
if ($Stress) {$checks += '--stress-test'}
if ($WithRuntime) {$checks += @('--self-test','--translation-test','--recovery-test')}
foreach ($check in $checks) {
    Write-Output "Running $check"
    $process = Start-Process -FilePath $binary -ArgumentList $check -WindowStyle Hidden -PassThru
    if (!$process.WaitForExit(300000)) {$process.Kill();throw "Check timed out: $check"}
    if ($process.ExitCode -ne 0) {throw "Check failed: $check; see reports in $AppDirectory"}
}
Write-Output 'All selected checks passed.'
