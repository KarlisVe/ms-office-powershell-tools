Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$setup = (Get-Content -Path link.txt  -TotalCount 3)

$link = $setup[0]
[int]$minLen = $setup[1]
[int]$maxLen = $setup[2]
Write-Verbose $link
# Set-Clipboard -Value "#12345 "
$idValue = (Get-Clipboard).Trim().Replace('#', '') | Where-Object { $_.Length -gt ($minLen-1) -and $_.Length -lt ($maxLen+1)}
Write-Verbose "idValue: $($idValue)"
if ($idValue) {
    $progToStart = $link.Replace('##change##', $idValue)
#    Write-Verbose "String started: $($progToStart)"
    Start-Process $progToStart
} else {
    Write-Verbose "Failed to start"
}