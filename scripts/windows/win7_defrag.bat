::
:: win7_defrag.bat
:: (c) 2020 Sam Caldwell.  See LICENSE.txt.
::
:: This script is the equivalent of 'compact.bat' but specific to windows7.
::
msiexec /qb /x C:\windows\Temp\sdelete.exe

net stop wuauserv

rmdir /S /Q C:\windows\SoftwareDistribution\Download

mkdir C:\windows\SoftwareDistribution\Download

net start wuauserv

cmd /c %SystemRoot%\System32\reg.exe ADD HKCU\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f
cmd /c C:\windows\Temp\sdelete.exe -q -z C:

cmd /c defrag c? -a -v
cmd /c defrag c? -u
