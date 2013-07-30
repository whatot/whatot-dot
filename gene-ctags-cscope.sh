#!/bin/sh
set -x
find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files
cscope -bkq -i cscope.files
ctags -R --fields=+lS
# ctags -R --c++-kinds=+px --fields=+iaS --extra=+q
