# K3S
Light-weight Kubernetes server.

# Table Of Contents
- [Overview](#overview)
- [Access](#access)

# Overview
A light-weight Kubernetes server used to run container workloads on my laptop.

# Access
First ensure the `k3s` service is started.

Then create an access token:

```
k3s kubectl -n kubernetes-dashboard create token admin-user
```

Then run the proxy: `k3s kubectl proxy` and access [the dashboard proxy link](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy)
