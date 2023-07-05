#!/usr/bin/env bash
set -eux

if [[ "$#" -eq 0 ]]; then
    cmd="ubuntu"
else
    cmd="$1"
fi

if [[ "${cmd}" = "ortools" ]]; then
    # https://github.com/google/or-tools/blob/stable/cmake/README.md
    cd ~/git/or-tools
    cmake -S. -Bbuild -DUSE_SCIP=OFF -DBUILD_DEPS=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
elif [[ "${cmd}" = "ubuntu" ]]; then
    sudo apt update
    sudo apt install --no-install-recommends build-essential pkg-config \
        ccache cmake clang clangd rtags ccls clang-format g++ \
        libabsl-dev protobuf-compiler libre2-dev libeigen3-dev libstdc++-12-dev \
        npm

    # https://github.com/regen100/cmake-language-server
    pip install cmake-language-server
    pip show cmake-language-server
fi
