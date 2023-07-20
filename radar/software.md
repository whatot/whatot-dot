# software

- 采纳 adopt
- 试验 trial
- 评估 assess
- 暂缓 hold

## os

- *adopt* archlinux
  - pros: 各种软件都能安装最新版，各类软件都能有维护与适配
  - cons: 需要自行维护配置，实现自动化部署与配置方案
- *trial* nixos
  - pros: 支持自动化部署与配置到指定状态
  - cons: 很多配置需要探索与试验，没有现成的情况下需要自行维护，国内专属软件无维护者，到日常易用比较难
- *assess* gentoo
- *hold* debian,ubuntu
  - pros: 系统部署容易；无复杂配置才能解决的问题
  - cons: 官方源软件版本低，部分软件需要慢速的ppa源，部分软件依旧无法找到；无法自动化部署与配置到指定状态
  - try: [mpr](https://mpr.makedeb.org/)

### nixos trial step

- https://github.com/gvolpe/nix-config
- https://github.com/nix-community/nix-doom-emacs

## deploy tools

- *adopt* ansible
- *trial* transform
- *trial* [portainer](https://docs.portainer.io/)
- *assess* [just](https://github.com/casey/just) [just备忘清单](https://wangchujiang.com/reference/docs/justfile.html)

## input method

- *trial* [felix zhwiki dict](https://github.com/felixonmars/fcitx5-pinyin-zhwiki)
- *trial* [rime coverpinyin](https://github.com/fkxxyz/rime-cloverpinyin)

## editor

- *adopt* doom emacs
- *adopt* vim
- *adopt* vscode
- *assess* neovim
- *assess* helix
- *assess* zen
