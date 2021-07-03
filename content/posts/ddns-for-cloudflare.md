---
title: "DDNS for Cloudflare"
date: 2021-05-30T16:22:46+08:00
toc: false
images:
tags: 
  - shell
  - linux
  - api
---
### 主程序
```shell
#!/usr/bin/bash
function check_and_update() {
  last_ip6=$(cat last_ip6)
  cur_ip6=$(mainipv6)
  if [ "$last_ip6" == "$cur_ip6" ]; then
    return 0
  fi
  curl -X PUT "https://api.cloudflare.com/client/v4/zones/{zoneId}/dns_records/{recordId}" \
     -H "Authorization: Bearer {Token}" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"AAAA\",\"name\":\"tivizi.cn\",\"content\":\"$cur_ip6\",\"ttl\":120,\"proxied\":true}"
  echo updated cf: $cur_ip6
  echo $cur_ip6 > last_ip6
}

while true; do
  check_and_update
  sleep 10
done
```
### mainipv6
```shell
#!/usr/bin/bash
ip addr | grep -C 5 enp1s0 | tail -n 4| head -n 1 | awk '{print $2}' | awk -F '/' '{print $1}'
```

