# See https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse

param (
  [switch]$AutoStart = $false
)

Write-Output "AutoStart: $AutoStart"
$is_64bit = [IntPtr]::size -eq 8

Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Configure OpenSSH Server
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
Get-NetFirewallRule -Name *ssh*
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

Stop-Service sshd

Write-Output "Setting vagrant user file permissions"
New-Item -ItemType Directory -Force -Path "C:\Users\vagrant\.ssh"
C:\Windows\System32\icacls.exe "C:\Users\vagrant" /grant "vagrant:(OI)(CI)F"
C:\Windows\System32\icacls.exe "C:\Program Files\OpenSSH\bin" /grant "vagrant:(OI)RX"
C:\Windows\System32\icacls.exe "C:\Program Files\OpenSSH\usr\sbin" /grant "vagrant:(OI)RX"

Write-Output "Setting SSH home directories"
    (Get-Content "C:\Program Files\OpenSSH\etc\passwd") |
    Foreach-Object { $_ -replace '/home/(\w+)', '/cygdrive/c/Users/$1' } |
    Set-Content 'C:\Program Files\OpenSSH\etc\passwd'

$passwd_file = Get-Content 'C:\Program Files\OpenSSH\etc\passwd'
Set-Content 'C:\Program Files\OpenSSH\etc\passwd' $passwd_file

# fix opensshd to not be strict
Write-Output "Setting OpenSSH to be non-strict"
$sshd_config = Get-Content "C:\Program Files\OpenSSH\etc\sshd_config"
$sshd_config = $sshd_config -replace 'StrictModes yes', 'StrictModes no'
$sshd_config = $sshd_config -replace '#PubkeyAuthentication yes', 'PubkeyAuthentication yes'
$sshd_config = $sshd_config -replace '#PermitUserEnvironment no', 'PermitUserEnvironment yes'

# disable the use of DNS to speed up the time it takes to establish a connection
$sshd_config = $sshd_config -replace '#UseDNS yes', 'UseDNS no'

# next time OpenSSH starts have it listen on th eproper port
$sshd_config = $sshd_config -replace 'Port 2222', "Port 22"
Set-Content "C:\Program Files\OpenSSH\etc\sshd_config" $sshd_config

Write-Output "Removing ed25519 key as Vagrant net-ssh 2.9.1 does not support it"
Remove-Item -Force -ErrorAction SilentlyContinue "C:\Program Files\OpenSSH\etc\ssh_host_ed25519_key"
Remove-Item -Force -ErrorAction SilentlyContinue "C:\Program Files\OpenSSH\etc\ssh_host_ed25519_key.pub"

# use c:\Windows\Temp as /tmp location
Write-Output "Setting temp directory location"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\Program Files\OpenSSH\tmp"
C:\Program` Files\OpenSSH\bin\junction.exe /accepteula "C:\Program Files\OpenSSH\tmp" "C:\Windows\Temp"
C:\Windows\System32\icacls.exe "C:\Windows\Temp" /grant "vagrant:(OI)(CI)F"

# add 64 bit environment variables missing from SSH
Write-Output "Setting SSH environment"
$sshenv = "TEMP=C:\Windows\Temp"
if ($is_64bit) {
    $env_vars = "ProgramFiles(x86)=C:\Program Files (x86)", `
        "ProgramW6432=C:\Program Files", `
        "CommonProgramFiles(x86)=C:\Program Files (x86)\Common Files", `
        "CommonProgramW6432=C:\Program Files\Common Files"
    $sshenv = $sshenv + "`r`n" + ($env_vars -join "`r`n")
}
Set-Content C:\Users\vagrant\.ssh\environment $sshenv

# record the path for provisioners (without the newline)
Write-Output "Recording PATH for provisioners"
Set-Content C:\Windows\Temp\PATH ([byte[]][char[]] $env:PATH) -Encoding Byte

# configure firewall
Write-Output "Configuring firewall"

netsh advfirewall firewall add rule name="SSHD" dir=in action=allow service=sshd enable=yes
netsh advfirewall firewall add rule name="ssh" dir=in action=allow protocol=TCP localport=22

if ($AutoStart -eq $true) {
    Start-Service sshd
}
