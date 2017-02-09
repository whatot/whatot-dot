#!/bin/bash
set -x

SCRIPT_DIR=`pwd`
SHM_DIR=/dev/shm
SOURCE_DIR=~/git/postgres
TARGET_DIR=${SHM_DIR}/postgres
INSTALL_DIR=${SHM_DIR}/pginstall
DATA_DIR=${SHM_DIR}/pgdata

git -C ~/git/postgres clean -fxd
mkdir ${TARGET_DIR}
mkdir ${INSTALL_DIR}
mkdir ${DATA_DIR}

rsync -avP --delete ~/git/postgres ${SHM_DIR}
cp ${SCRIPT_DIR}/clang_complete.postgres ${TARGET_DIR}/.clang_complete
cp ${SCRIPT_DIR}/ycm_extra_conf.py ${TARGET_DIR}/.ycm_extra_conf.py
cp ${SCRIPT_DIR}/gene-gtags.sh ${TARGET_DIR}/gene-gtags.sh
cp ${SCRIPT_DIR}/postgres.dir-locals.el ${TARGET_DIR}/.dir-locals.el

cd ${TARGET_DIR}
git checkout REL9_6_STABLE
./configure --prefix=${INSTALL_DIR} \
    --enable-debug \
    --sysconfdir=/etc \
    --with-gssapi \
    --with-libxml \
    --with-openssl \
    --with-perl \
    --with-python PYTHON=/usr/bin/python2 \
    --with-tcl \
    --with-pam \
    --with-system-tzdata=/usr/share/zoneinfo \
    --with-uuid=e2fs \
    --enable-nls \
    --enable-thread-safety

make install
make clean
bash ./gene-gtags.sh
