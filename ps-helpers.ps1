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