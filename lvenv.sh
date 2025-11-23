#!/bin/bash

dir="$(pwd)/$1"

cd "$dir"

[ -d "venv" ] || mkdir venv
cd venv

cat << EOF > activate
[ "\$oldPROMPT" ] || oldPROMPT="\$PS1"

PS1="[lvenv] \$PS1"

alias lua="$dir/venv/bin/lua"
alias luac="$dir/venv/bin/luac"

deactivate() {
	PS1="\$oldPROMPT"

	unalias lua
	unalias luac
}
EOF

[ -d "bin" ] || mkdir bin
 
cp /bin/lua bin/  &
cp /bin/luac bin/ &

wait
