@echo off
del /f /s /q "C:\Users\Administrator\.config\clash\logs\*.*"
rd /s /q "C:\Users\Administrator\AppData\Roaming\clash_win"
del /f /s /q "C:\Windows\Temp\*.*"
rd /s /q "C:\Windows\Temp\"
del /f /s /q "C:\Users\Administrator\AppData\Local\Temp\*.*"
rd /s /q "C:\Users\Administrator\AppData\Local\Temp\"
del /f /s /q "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service\*.*"
rd /s /q "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service\"
del /f /s /q "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Results\*.*"
rd /s /q "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Results\"
pause