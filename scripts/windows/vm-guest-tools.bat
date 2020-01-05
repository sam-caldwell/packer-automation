if not exist "C:\windows\Temp\7z920-x64.msi" (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://www.7-zip.org/a/7z920-x64.msi', 'C:\windows\Temp\7z920-x64.msi')" <NUL
)
msiexec /qb /i C:\windows\Temp\7z920-x64.msi

if "%PACKER_BUILDER_TYPE%" equ "vmware-iso" goto :vmware
if "%PACKER_BUILDER_TYPE%" equ "virtualbox-iso" goto :virtualbox
if "%PACKER_BUILDER_TYPE%" equ "parallels-iso" goto :parallels
goto :done

:vmware

if exist "C:\Users\vagrant\windows.iso" (
    move /Y C:\Users\vagrant\windows.iso C:\windows\Temp
)

if not exist "C:\windows\Temp\windows.iso" (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://softwareupdate.vmware.com/cds/vmw-desktop/ws/12.0.0/2985596/windows/packages/tools-windows.tar', 'C:\windows\Temp\vmware-tools.tar')" <NUL
    cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\windows\Temp\vmware-tools.tar -oC:\windows\Temp"
    FOR /r "C:\windows\Temp" %%a in (VMware-tools-windows-*.iso) DO REN "%%~a" "windows.iso"
    rd /S /Q "C:\Program Files (x86)\VMWare"
)

cmd /c ""C:\Program Files\7-Zip\7z.exe" x "C:\windows\Temp\windows.iso" -oC:\windows\Temp\VMWare"
cmd /c C:\windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"

goto :done

:virtualbox

move /Y C:\Users\vagrant\VBoxGuestAdditions.iso C:\windows\Temp
cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\windows\Temp\VBoxGuestAdditions.iso -oC:\windows\Temp\virtualbox"
cmd /c for %%i in (C:\windows\Temp\virtualbox\cert\vbox*.cer) do C:\windows\Temp\virtualbox\cert\VBoxCertUtil add-trusted-publisher %%i --root %%i
cmd /c C:\windows\Temp\virtualbox\VBoxwindowsAdditions.exe /S
goto :done

:parallels
if exist "C:\Users\vagrant\prl-tools-win.iso" (
	move /Y C:\Users\vagrant\prl-tools-win.iso C:\windows\Temp
	cmd /C "C:\Program Files\7-Zip\7z.exe" x C:\windows\Temp\prl-tools-win.iso -oC:\windows\Temp\parallels
	cmd /C C:\windows\Temp\parallels\PTAgent.exe /install_silent
	rd /S /Q "c:\windows\Temp\parallels"
)

:done
msiexec /qb /x C:\windows\Temp\7z920-x64.msi
