## Problems tested
# table borders -> become without color
# could be problems with merged tables (works sma)

$path = "$(Get-Location)\doc\"
$outPath = "$(Get-Location)\docx"
$word_app = New-Object -ComObject Word.Application

$Format = [Microsoft.Office.Interop.Word.WdSaveFormat]::wdFormatXMLDocument

Get-ChildItem -Path $path | Where-Object{$_.Extension.ToLower() -eq '.doc'} | ForEach-Object {
    $document = $word_app.Documents.Open($_.FullName)
    $docx_filename = "$($outPath)\$($_.BaseName).docx" #$_.DirectoryName
    $document.SaveAs([ref] $docx_filename, [ref]$Format)
    $document.Close()
}
$word_app.Quit()