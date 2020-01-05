rem install rsync
if not exist "C:\windows\Temp\7z920-x64.msi" (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://www.7-zip.org/a/7z920-x64.msi', 'C:\windows\Temp\7z920-x64.msi')" <NUL
)
msiexec /qb /i C:\windows\Temp\7z920-x64.msi

pushd C:\windows\Temp
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://mirrors.kernel.org/sourceware/cygwin/x86_64/release/rsync/rsync-3.1.2-1.tar.xz', 'C:\windows\Temp\rsync-3.1.2-1.tar.xz')" <NUL
cmd /c ""C:\Program Files\7-Zip\7z.exe" x rsync-3.1.2-1.tar.xz"
cmd /c ""C:\Program Files\7-Zip\7z.exe" x rsync-3.1.2-1.tar"
copy /Y usr\bin\rsync.exe "C:\Program Files\OpenSSH\bin\rsync.exe"
rmdir /s /q usr
del rsync-3.1.2-1.tar
popd

msiexec /qb /x C:\windows\Temp\7z920-x64.msi

rem make symlink for c:/vagrant share
mklink /D "C:\Program Files\OpenSSH\vagrant" "C:\vagrant"
