#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." >&2
    exit 1
fi

pwquality="/etc/security/pwquality.conf"

if [[ ! -e "$pwquality" ]]; then
        apt update
        apt install -y libpam-pwquality
fi

values=("minlen" "ucredit" "lcredit" "dcredit" "ocredit")

declare -A configs=(
        [minlen]=15
        [ucredit]=-1
        [lcredit]=-1
        [dcredit]=-1
        [ocredit]=-1
)

for i in "${values[@]}"; do
        if grep -q -E "^[[:space:]]*#?[[:space:]]*${i}" "$pwquality"; then
                sed -i "s/^[[:space:]]*#*[[:space:]]*${i}.*/${i} = ${configs[$i]}/" "$pwquality"
         else
                echo "${i} = ${configs[$i]}" >> "$pwquality"
        fi
done

