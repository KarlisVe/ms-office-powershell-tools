Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# https://jackgruber.github.io/2018-05-11-ps-get-process-output/
function Get-ProcessOutput
{
    Param (
                [Parameter(Mandatory=$true)]$FileName,
                $Arguments
    )

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo.UseShellExecute = $false
    $process.StartInfo.RedirectStandardOutput = $true
    $process.StartInfo.RedirectStandardError = $true
    $process.StartInfo.FileName = $FileName
    if($Arguments) { $process.StartInfo.Arguments = $Arguments }
    $out = $process.Start()
    Write-Verbose $out

    $StandardError = $process.StandardError.ReadToEnd()
    $StandardOutput = $process.StandardOutput.ReadToEnd()

    $output = New-Object PSObject
    $output | Add-Member -type NoteProperty -name StandardOutput -Value $StandardOutput
    $output | Add-Member -type NoteProperty -name StandardError -Value $StandardError
    return $output
}

$author = $(git config user.name)
# $email = $(git config user.email)
$today = (Get-Date)
$revsUntil = $today.AddDays(-1) #TODO
$revsStart = $today.AddDays(-1)
$typePrint = ' --oneline' # --pretty=format:"%h%x09%an%x09%ad%x09%s" %d/%D branch namee
$typePrint = ' --pretty=format:"%C(auto)%D"'

if ( "Monday" -eq $today.DayOfWeek) {
    $revsStart = $today.AddDays(-2)
}

$command = "/c git rev-list --all --remotes$typePrint" + ' --author="' + $($author) + '"' + " --since=$($revsStart.ToString("yyyy-MM-dd")) --until=$($revsUntil.ToString("yyyy-MM-dd"))" # --pretty

Write-Verbose "cmd.exe $command"

$output = Get-ProcessOutput -FileName "cmd.exe" -Arguments "$command"
Write-Verbose $output.StandardOutput
Write-Host -ForegroundColor red $output.StandardError

$outputFilter = ($output.StandardOutput.Split([Environment]::NewLine)) | Select-String -Pattern "commit" -CaseSensitive -NotMatch | Select-String -Pattern "#[0-9]{4,6}"


# Write-host "Filter"
$regexBranchInfo = (Get-Content -Path 'issue-pattern.txt')
$listOfBranches = @()
foreach ($line in $outputFilter) {
    Write-Verbose "Filter line: $line"
    if ($line -match $regexBranchInfo) {
        $match = $Matches[0]
        # Write-host $matches[0]

        if ($match -and $listOfBranches -notcontains $match) {
            $listOfBranches += $match
        }
    }
}

Write-Host $listOfBranches
Set-Clipboard -Value $listOfBranches