#!/bin/sh

dir="$(pwd)/$1"

cd "$dir"

[ -d "venv" ] || mkdir venv
cd venv

cat << EOF > activate
[ "\$oldPROMPT" ] || oldPROMPT="\$PS1"
[ "\$oldLUA_PATH" ] || oldLUA_PATH="\$LUA_PATH"
[ "\$oldLUA_CPATH" ] || oldLUA_CPATH="\$LUA_CPATH"

PS1="[lvenv] \$PS1"

alias lua="$dir/venv/bin/lua"
alias luac="$dir/venv/bin/luac"

export LUA_PATH="${dir}/?.lua;${dir}/?/init.lua;;"
export LUA_CPATH="${dir}/?.so;${dir}/?/loadall.so;;"

deactivate() {
	PS1="\$oldPROMPT"

	unalias lua
	unalias luac

	export LUA_PATH="$oldLUA_PATH"
	export LUA_CPATH="$oldLUA_CPATH"
}
EOF

[ -d "bin" ] || mkdir bin
 
cp /bin/lua bin/  &
cp /bin/luac bin/ &

wait
