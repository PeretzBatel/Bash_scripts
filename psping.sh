#! /bin/bash

c="0"
t=1
u="any"
exe_name=""

while getopts c:t:u: option; do
    case "${option}" in
    c)
        c="$OPTARG"
        ;;
    t)
        t="$OPTARG"
        ;;
    u)
        u="$OPTARG"
        ;;
    esac
done

input_args="$*"
for item in ${input_args}; do
    exe_name=$item
done
echo

count=1
while (true); do
    if [ "$c" -ne "0" ]; then
        if [ "$count" -eq "$c" ]; then
            break
        fi
    fi
    ((count++))
    clear
    if [ "$u" -eq "any" ]; then
        timeout $t ps -C $exe_name -eo user,cmd
    else
        timeout $t ps -u $u -C $exe_name -eo user,cmd
    fi
    sleep 1
done
