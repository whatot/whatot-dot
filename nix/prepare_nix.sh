#!/usr/bin/env bash
set -eux

if [[ "$#" -eq 0 ]]; then
    cmd="init"
else
    cmd="$1"
fi

function run_in_mac() {
    case ${cmd} in
        init)
            echo -n "init nix in macos"
            ;;
        upgrade)
            echo -n "upgrade nix in macos"
            ;;
        *)
            echo -n "unsupported cmd (${cmd}) in macos"
            ;;
    esac
}

# https://nixos-and-flakes.thiscute.world/zh/nixos-with-flakes/introduction-to-flakes
# https://serokell.io/blog/practical-nix-flakes
# https://nixos.wiki/wiki/flakes#Installing_flakes
# https://mirrors.ustc.edu.cn/help/nix-channels.html
# https://nixos.org/manual/nix/stable/installation/upgrading.html

function run_in_ubuntu() {
    case ${cmd} in
        init)
            echo -n "init nix in macos"
            bash <(curl -L https://nixos.org/nix/install) --no-daemon

            nix-channel --add https://mirrors.ustc.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
            nix-channel --update
            # 替换 binary cache 为科大源
            # vim ~/.config/nix/nix.conf
            # substituters = https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/
            # experimental-features = nix-command flakes
            nix-env -f '<nixpkgs>' -iA nixUnstable

            ;;
        upgrade)
            echo -n "upgrade nix in macos"
            nix-channel --update
            nix-env --install --attr nixpkgs.nix nixpkgs.cacert
            ;;
        *)
            echo -n "unsupported cmd (${cmd}) in macos"
            ;;
    esac
}

case $(uname) in
    Darwin)
        run_in_mac
        ;;
    Linux)
        OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
        case ${OS_ID} in
            ubuntu)
                run_in_ubuntu
                ;;
            *)
                echo -n "unsupported os id: ${OS_ID}"
                ;;
        esac
        ;;
    *)
        echo -n "unsuppprted os"
        ;;
esac
