:: windows 7 SP1 require KB3102810 hotfix
:: Installing and searching for updates is slow and high CPU usage occurs in windows 7.
:: https://support.microsoft.com/en-us/kb/3102810

@echo off

@powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://create.sh/packer-automation/windows/windows6.1-KB3102810-x64.msu', 'C:\windows\Temp\windows6.1-KB3102810-x64.msu'))"

set hotfix="C:\windows\Temp\windows6.1-KB3102810-x64.msu"
if not exist %hotfix% goto :eof

:: get windows version
for /f "tokens=2 delims=[]" %%G in ('ver') do (set _version=%%G)
for /f "tokens=2,3,4 delims=. " %%G in ('echo %_version%') do (set _major=%%G& set _minor=%%H& set _build=%%I)

:: 6.1
if %_major% neq 6 goto :eof
if %_minor% lss 1 goto :eof

@echo on
start /wait wusa "%hotfix%" /quiet
