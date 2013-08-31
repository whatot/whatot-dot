#!/bin/sh
set -x
find . -name "*.h" -o -name "*.c" -o -name "*.cc" > gtags.files
# cscope -bkq -i gtags.files
# ctags -R --fields=+lS
# ctags -R --c++-kinds=+px --fields=+iaS --extra=+q
gtags
