---
title: "Components of Kubernetes"
date: 2020-09-04T10:14:31+08:00
toc: false
images:
tags: 
  - untagged
---
### Control Plane节点进程树：
```
+systemd:
  - kube-apiserver
  - kube-scheduler
  - kube-controller-manager
  - etcd
```

### Work Plane节点进程树：
```
+systemd:
  - kubelet
  - containerd
```

### 覆盖网络
~~kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml~~
```
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

### Cluser IP Supports
https://www.bookstack.cn/read/kubernetes-practice-guide/deploy-addons-kube-proxy.md

### 容器调试工具`crictl`
```
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: crictl-amd64-ds
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: crictl-amd64-ds
  updateStrategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: crictl-amd64-ds
    spec:
      containers:
      - name: crictl
        image: containers.v2pod.com/k8s/crictl:containerd
        imagePullPolicy: IfNotPresent
        securityContext:
          privileged: true
        volumeMounts:
        - mountPath: /run/containerd/containerd.sock
          name: containerd
      volumes:
      - name: containerd
        hostPath:
          path: /run/containerd/containerd.sock
EOF
```
打完收工。
