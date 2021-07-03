---
title: "iproute2 日常实践"
toc: false
images:
tags: 
  - untagged
date:   2019-11-25 21:45:41 +0800
---
### ip addr
```shell
# 网卡指定IP地址，这会自动为该网卡添加一条路由，`src` 为192.168.0.1的数据包，会有该网卡转发到子网
ip addr add 192.168.0.1/24 dev `interface`

```

### ip route
```shell
# 列出本机所有路由
ip route

# 添加一条路由，所有本机产生的或发往本机需要转发的到`CIDR`
# 网络的IP数据包都将交由网卡`interface`发往`gateway`
ip route add `CIDR` via `gateway` dev `interface`

```


