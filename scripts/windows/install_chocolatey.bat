::
:: install_chocolatey.bat
:: (c) 2020 Sam Caldwell.  See LICENSE.txt.
:: This script install chocolatey.
::

powershell -command "Set-ExecutionPolicy -Scope CurrentUser RemoteSigned"
powershell -command "Get-ExecutionPolicy -List"
powershell -command "iwr 'https://chocolatey.org/install.ps1' -UseBasicParsing | iex"

C:\ProgramData\chocolatey\bin\choco.exe upgrade chocolatey
