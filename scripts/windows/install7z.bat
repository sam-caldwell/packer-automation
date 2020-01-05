if not exist "C:\windows\Temp\7z920-x64.msi" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://www.7-zip.org/a/7z920-x64.msi', 'C:\windows\Temp\7z920-x64.msi')" <NUL
)
msiexec /qb /i C:\windows\Temp\7z920-x64.msi
