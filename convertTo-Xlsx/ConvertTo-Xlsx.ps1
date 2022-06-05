$path = "$(Get-Location)\xls\"
$excel_app = New-Object -ComObject Excel.Application
$excel_app.visible = $true

$Format = [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook

Get-ChildItem -LiteralPath $path | Where-Object{$_.Extension.ToLower() -eq '.xls'} | ForEach-Object {
    Write-Host "Processed: " + $_.FullName
    $document = $excel_app.Workbooks.Open($_.FullName)
    $xlsx_filename = "$($_.DirectoryName)\$($_.BaseName).xlsx"
    $document.SaveAs([ref] $xlsx_filename, [ref]$Format)
    $document.Close()
}
$excel_app.Quit()