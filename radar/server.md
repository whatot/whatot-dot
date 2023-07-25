# server

- 采纳 adopt
- 试验 trial
- 评估 assess
- 暂缓 hold

## os

### os on bare metal

- *trial* pve

### os under k8s

> https://thenewstack.io/looking-for-a-k3os-alternative-choosing-a-container-os-for-edge-k8s/

- *assess* [talos linux](https://github.com/siderolabs/talos)
- *assess* [Flatcar Container Linux](https://github.com/flatcar/Flatcar)
- *assess* [Kairos](https://github.com/kairos-io/kairos)
- *assess* [rancher k8os](https://github.com/rancher/k3os)
- *hold* [aws bottlerocket](https://github.com/bottlerocket-os/bottlerocket)

### os for normal server

- *adopt* debian

## k8s

### container management

- *assess* [portainer](https://docs.portainer.io/) 支持 Docker/k3s/nomad 多种编排服务的管理服务
- *assess* [nomad](https://github.com/hashicorp/nomad) 入门门槛较低但缺乏教学资料的编排服务
- *assess* k3s
- *assess* kubernetes
- *hold* KubeSphere

### gateway

- *assess* [traefik](https://doc.traefik.io/traefik/) "最好用的网关服务"
- *assess* [caddy](https://caddyserver.com/) 简单好用的支持 Let's Encrypt 的网关服务
- *assess* nginx

### gitops or auto

- *assess* ansible 自动化部署
- *assess* terraform 只要有接口管理的服务都能自动化部署的工具,还是 ansible 最佳排挡
- *assess* [fluxcd](https://fluxcd.io/flux/) 最好用的 gitops 里对 k8s 自动配置部署工具
- *assess* [argocd](https://argo-cd.readthedocs.io) gitops 里对 k8s 自动配置部署还有可视化拓扑图
- *assess* [pulumi](https://www.pulumi.com/) 支持多种原生语言配置版本的 terraform 实现架构优秀，使用者友好，插件开发者痛苦
- *assess* [openlens](https://github.com/lensapp/lens) Kubernetes IDE
- *assess* [just](https://github.com/casey/just) [just备忘清单](https://wangchujiang.com/reference/docs/justfile.html)

## network

- *assess* [nebula](https://github.com/slackhq/nebula)
- *assess* [tailscale](https://github.com/tailscale/tailscale) [headscale](https://github.com/juanfont/headscale)

## managed services

> - https://github.com/awesome-selfhosted/awesome-selfhosted
> - https://github.com/tborychowski/self-hosted-cookbook

- dns
  - *adopt* [AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)
  - *assess* [pi-hole](https://github.com/pi-hole/pi-hole)
- ebook
- rss
