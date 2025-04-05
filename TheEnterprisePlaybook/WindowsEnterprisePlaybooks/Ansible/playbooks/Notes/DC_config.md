# Windows Domain Controller Configuration

1. Rename the Server
Replace DC01 with your desired hostname:

```powershell
Rename-Computer -NewName "DC01" -Restart
```

2. Set a Static IP Address
Adjust the interface index (Index) and IP address as needed:

```powershell
$interfaceIndex = (Get-NetAdapter).InterfaceIndex
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress 192.168.1.10 -PrefixLength 24 -DefaultGateway 192.168.1.1
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses 192.168.1.10
```

3. Set the Time Zone

```powershell
Set-TimeZone -Id "Eastern Standard Time"
```

4. Install Active Directory Domain Services (AD DS)

```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
```

5. Promote Server to a Domain Controller
Set the Safe Mode Administrator Password and create the new domain test.domain:

```powershell
$SecurePassword = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force

Install-ADDSForest `
  -DomainName "test.domain" `
  -ForestMode "Win2016" `
  -DomainMode "Win2016" `
  -SafeModeAdministratorPassword $SecurePassword `
  -InstallDns `
  -Force
```

The server will reboot automatically.

6. Verify Domain Controller Installation
After the reboot, check if the domain controller is active:

```powershell
Get-ADDomain
Get-ADForest
Get-Service -Name NTDS
```
