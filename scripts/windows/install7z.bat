if not exist "C:\windows\Temp\7z920-x64.msi" (
	powershell -Command "do{sleep 5;(New-Object Net.WebClient).DownloadFile('https://create.sh/packer-automation/windows/7z920-x64.msi')}while(!$?)" <NULL
)
msiexec /qb /i C:\windows\Temp\7z920-x64.msi

