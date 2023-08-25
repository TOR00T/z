Windows7:

shift+F10

lusrmgr

taskmgr

End task msoobe.exe

Windows10\Windows11:

Ctrl+Shift+F3

C:\Windows\System32\oobe\audit.exe -> C:\Windows\

XCOPY %windir%\System32\svchost.exe %windir%\System32\oobe\audit.exe /X

y

XCOPY %windir%\audit.exe %windir%\System32\oobe\audit.exe /X

y

del C:\Windows\audit.exe