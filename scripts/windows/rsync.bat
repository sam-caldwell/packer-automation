rem install rsync
if not exist "C:\windows\Temp\7z920-x64.msi" (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://create.sh/packer-automation/windows/7z920-x64.msi', 'C:\windows\Temp\7z.msi')" <NUL
)
msiexec /qb /i C:\windows\Temp\7z.msi

pushd C:\windows\Temp
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://create.sh/packer-automation/windows/rsync-3.1.2-1.tar.xz', 'C:\windows\Temp\rsync.tar.xz')" <NUL
cmd /c ""C:\Program Files\7-Zip\7z.exe" x rsync.tar.xz"
cmd /c ""C:\Program Files\7-Zip\7z.exe" x rsync.tar"
copy /Y usr\bin\rsync.exe "C:\Program Files\OpenSSH\bin\rsync.exe"
rmdir /s /q usr
del rsync.tar
popd

msiexec /qb /x C:\windows\Temp\7z.msi

rem make symlink for c:/vagrant share
mklink /D "C:\Program Files\OpenSSH\vagrant" "C:\vagrant"
