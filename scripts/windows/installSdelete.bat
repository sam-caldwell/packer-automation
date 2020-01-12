if not exist "C:\windows\Temp\SDelete.zip" (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://create.sh/packer-automation/windows/SDelete.zip', 'C:\windows\Temp\SDelete.zip')" <NUL
)

if not exist "C:\windows\Temp\sdelete.exe" (
	cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\windows\Temp\SDelete.zip -oC:\windows\Temp"
)
