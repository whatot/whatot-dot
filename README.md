# whatot-dot

- vim `./vim/deploy-tiny.sh`
- doom emacs `./doom/deploy-doom.sh`
- zsh `./zsh/deploy-zshrc.sh`
- golang `./golang/install-golang.sh`
- rust `./rust/install-rust-self.sh`

## ansible

The `arch.yml` in `ansible/` will install all needed packages,
and configure the localhost well.

> Only support Archlinux and Manjaro

```
cd ansible/
./config-arch.sh
```

## use python venv

[venv](https://docs.python.org/3/library/venv.html)

```
mkdir -p $WORKON_HOME
python3 -m venv $WORKON_HOME/env3
```
