# whatot-dot

- vim `./vim/deploy-tiny.sh`
- doom emacs `./doom/deploy-doom.sh`
- zsh `./zsh/deploy-zshrc.sh`
- rust `./rust/install-rust-self.sh`
- language
  - cc `./lang/cc.sh`
  - golang `./lang/golang.sh`

## ansible

The `arch.yml` in `ansible/` will install all needed packages, and configure the localhost well.

> Only support Archlinux and Manjaro

```shell
cd ansible/
./config-arch.sh
```

## use python venv

[venv](https://docs.python.org/3/library/venv.html)

```shell
mkdir -p ~/envs
python3 -m venv ~/envs/e3
source ~/envs/e3/bin/activate
deactivate
```
