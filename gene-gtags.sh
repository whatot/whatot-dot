#!/bin/sh
set -x

# find . -name "*.h" -o -name "*.c" -o -name "*.cc" > gtags.files
# find ./ -type f -name "*.[ch]" ! -path "./src/test/*" > gtags.files
# find $(pwd)/ -type f -name "*.[ch]" ! -path "$(pwd)/src/test/*" > gtags.files
find $(pwd) -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" > gtags.files
# cscope -bkq -i gtags.files
# ctags -R --fields=+lS
# ctags -R --c++-kinds=+px --fields=+iaS --extra=+q
gtags


### for path exclude ###
#
# $ mkdir a b c d e
# $ touch a/1 b/2 c/3 d/4 e/5 e/a e/b
# $ find . -type f ! -path "./a/*" ! -path "./b/*"
#
# ./d/4
# ./c/3
# ./e/a
# ./e/b
# ./e/5
