$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"

if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
    throw "7 zip file '$7zipPath' not found"
}

Set-Alias 7z $7zipPath

$pathDocx="$(Get-Location)\docx"
$pathExtract="$(Get-Location)\officeMedia"
$pathMedia="$($pathExtract)\word\media"
$pathLog="$($pathExtract)\files.log"

## TODO don't forget to comment
# Remove-Item -LiteralPath $pathExtract -Recurse

Get-ChildItem -Path $pathDocx | Where-Object{$_.Extension.ToLower() -eq '.docx'} | ForEach-Object {
    $fileName="$($_.BaseName)$($_.Extension)"
    7z x $($_.FullName) "word/media" -o"$($pathExtract)" -r
    Test-Path -LiteralPath "$($pathMedia)"

    Get-ChildItem -LiteralPath "$($pathMedia)" -Recurse -File | ForEach-Object {
        $fileHash=(Get-FileHash $_.FullName).Hash
        $fileNameMedia="$($_.BaseName)$($_.Extension)"
        $fileNameMediaResult=$pathExtract + "\$($fileHash)" + $_.Extension # -$($_.BaseName)".Substring(0,50)
        Write-Output "$fileName, $fileNameMediaResult, $($fileNameMedia)" | Out-File -FilePath $pathLog -Append #, $($_.Length/1MB)
        Move-Item $_.FullName -Destination $fileNameMediaResult -Force
    }
    Remove-Item -LiteralPath "$($pathExtract)\word" -Recurse
}