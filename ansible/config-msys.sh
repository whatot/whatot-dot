#!/usr/bin/env bash
set -eux

# download msys2 and install
# http://mirrors.ustc.edu.cn/msys2/distrib/msys2-x86_64-latest.exe

cat << EOF > "/etc/pacman.d/mirrorlist.msys"
Server = http://mirrors.ustc.edu.cn/msys2/msys/\$arch
Server = http://repo.msys2.org/msys/\$arch/
Server = https://sourceforge.net/projects/msys2/files/REPOS/MSYS2/\$arch/
Server = http://www2.futureware.at/~nickoe/msys2-mirror/msys/\$arch/
Server = https://mirror.yandex.ru/mirrors/msys2/msys/\$arch/
EOF

cat << EOF > "/etc/pacman.d/mirrorlist.mingw64"
Server = http://mirrors.ustc.edu.cn/msys2/mingw/x86_64
Server = http://repo.msys2.org/mingw/x86_64/
Server = https://sourceforge.net/projects/msys2/files/REPOS/MINGW/x86_64/
Server = http://www2.futureware.at/~nickoe/msys2-mirror/mingw/x86_64/
Server = https://mirror.yandex.ru/mirrors/msys2/mingw/x86_64/
EOF

cat << EOF > "/etc/pacman.d/mirrorlist.mingw32"
Server = http://mirrors.ustc.edu.cn/msys2/mingw/i686
Server = http://repo.msys2.org/mingw/i686/
Server = https://sourceforge.net/projects/msys2/files/REPOS/MINGW/i686/
Server = http://www2.futureware.at/~nickoe/msys2-mirror/mingw/i686/
Server = https://mirror.yandex.ru/mirrors/msys2/mingw/i686/
EOF

# config path for rust
PATH_LINE='export PATH="$USERPROFILE\.cargo\bin":$PATH'
PROFILE_FILE="$HOME"/.bashrc
grep -qF -- "$PATH_LINE" "$PROFILE_FILE" || echo "$PATH_LINE" >> "$PROFILE_FILE"

# install basic pkg
# if run cmake with missing shared library error, try run it in old windows cmd
pacman -Syyu
pacman -S git make
pacman -S mingw-w64-x86_64-toolchain 
pacman -S mingw-w64-x86_64-libpsl mingw-w64-x86_64-cmake