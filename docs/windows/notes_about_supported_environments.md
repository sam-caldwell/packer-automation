Notes about Supported Windows Environments
==========================================

## Server Standard Edition is the Default.
* All Windows Server versions are defaulted to the Server Standard edition. 
  You can modify this by editing the Autounattend.xml file, changing 
  the `ImageInstall`>`OSImage`>`InstallFrom`>`MetaData`>`Value` element
  (e.g. to Windows Server 2012 R2 SERVERDATACENTER).

## Product Keys
The `Autounattend.xml` files are configured to work correctly with trial 
ISOs (which will be downloaded and cached for you the first time you 
perform a `packer build`). If you would like to use retail or volume 
license ISOs, you need to update the `UserData`>`ProductKey` element 
as follows:

* Uncomment the `<Key>...</Key>` element
* Insert your product key into the `Key` element

If you are going to configure your VM as a KMS client, you can use the 
product keys at http://technet.microsoft.com/en-us/library/jj612867.aspx. 
These are the default values used in the `Key` element.

### Windows Updates

The scripts in this repo will install all Windows updates – by default – 
during Windows Setup. This is a _very_ time consuming process, depending 
on the age of the OS and the quantity of updates released since the last 
service pack. You might want to do yourself a favor during development and 
disable this functionality, by commenting out the `WITH WINDOWS UPDATES` 
section and uncommenting the `WITHOUT WINDOWS UPDATES` section 
in `Autounattend.xml`:

```xml
<!-- WITHOUT WINDOWS UPDATES -->
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\openssh.ps1 -AutoStart</CommandLine>
    <Description>Install OpenSSH</Description>
    <Order>99</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
<!-- END WITHOUT WINDOWS UPDATES -->
<!-- WITH WINDOWS UPDATES -->
<!--
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c a:\microsoft-updates.bat</CommandLine>
    <Order>98</Order>
    <Description>Enable Microsoft Updates</Description>
</SynchronousCommand>
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\openssh.ps1</CommandLine>
    <Description>Install OpenSSH</Description>
    <Order>99</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\win-updates.ps1</CommandLine>
    <Description>Install Windows Updates</Description>
    <Order>100</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
-->
<!-- END WITH WINDOWS UPDATES -->
```

Doing so will give you hours back in your day, which is a good thing.

### OpenSSH / WinRM

Currently, [Packer](http://packer.io) has a single communicator that uses 
SSH. This means we need an SSH server installed on Windows - which is not
optimal as we could use WinRM to communicate with the Windows VM. In the 
short term, everything works well with SSH; in the medium term, work is 
underway on a WinRM communicator for Packer.

If you have serious objections to OpenSSH being installed, you can always
add another stage to your build pipeline:

* Build a base box using Packer

* Create a Vagrantfile, use the base box from Packer, connect to the VM 
via WinRM (using the [vagrant-windows](https://github.com/WinRb/vagrant-windows) plugin) and disable the 'sshd' service or uninstall OpenSSH completely

* Perform a Vagrant run and output a .box file

It's worth mentioning that many Chef cookbooks will not work properly 
through Cygwin's SSH environment on Windows. Specifically, packages 
that need access to environment-specific configurations such as the 
`PATH` variable, will fail. This includes packages that use the Windows 
installer, `msiexec.exe`.

It's currently recommended that you add a second step to your pipeline
and use Vagrant to install your packages through Chef.
