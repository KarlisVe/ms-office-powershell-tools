# Office tools

## List of tools

* `ConvertTo-Docx` - converts doc files in one folder to docx and saves in another folder (see for know issues in source file - borders for tables)
* `ConvertTo-Xlsx` - converts xls files to xlsx and stores in same directory
* `Extract-office-media` - extracts media files from docx, xlsx and stores in `offficeMedia` folder
* `open-link-with-clipboard` - start https (but not limted) with specific link where part of it is replaced by data from clipboard

**Important** tools are not heavily tested at the moment.

Scripts will be maintened feel free to submit tickets or pull requests

## SonarCloud

**!Important** At the moment (2022.06.16) SonarQube does not support PowerShell scripts. But left for moment it will be [forum](https://community.sonarsource.com/t/powershell-script-scan-in-sonar/54533).

* Download Windows Sonar Scanner CLI and put to path
* Remember to setup SONAR_TOKEN

```batch
setx SONAR_TOKEN <token>
```

<https://sonarcloud.io/project/configuration?id=KarlisVe_ms-office-powershell-tools&analysisMode=GitHubManual>