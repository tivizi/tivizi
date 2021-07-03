---
title: "curl 日常实践"
date: 2019-11-29 14:22:41 +0800
toc: false
images:
tags: 
  - untagged
---
## HTTP协议相关

```shell
# 下载多个文件
curl -o `dist path`/#1.txt http://dtxc.org/\{text1, text2\}.txt

# `-s`选项，屏蔽了请求进度信息（--silent 静默）
# `-S`选项，在用了静默模式后，请求出错信息也不会显示，加上此选项，可以在输出错误信息。仅在`-s`选项存在时有效
curl -s -S https://dtxc.org -o dtxc.org.html

# REST资源常用选项
# `-X`指定请求方式，`-H`指定请求头信息（此选项可以有多个），`-d`指定请求体
curl -X POST -H 'X-Header: Header' -d '{"hello": "world"}' https://dtxc.org/null


# 利用头信息盗链
# 需要从`https://dtxc.org/home`页面才能访问`http://dtxc.org/after-home`
curl -H 'Referer: https://dtxc.org/home' http://dtxc.org/after-home

# 保存响应头信息到文件
curl -D header.txt https://dtxc.org/
```

## POP3和SMTP
TBD...

