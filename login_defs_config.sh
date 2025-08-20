#!/bin/bash

path="/etc/login.defs"

values=('LOGIN_TIMEOUT' 'PASS_MAX_DAYS' 'PASS_MIN_DAYS' 'PASS_WARN_AGE' 'LOGIN_RETRIES')

declare -A configs=(
        [LOGIN_TIMEOUT]=180
        [PASS_MAX_DAYS]=90
        [PASS_MIN_DAYS]=0
        [PASS_WARN_AGE]=14
        [LOGIN_RETRIES]=3
)

for i in "${values[@]}"; do

        if grep -q "^${i}" "$path"; then
                sed -i "s/^\(${i}[[:space:]]*\).*/\1 ${configs[$i]}/" "$path"
        else
                echo "${i} ${configs[$i]}" >> "$path"
        fi
done

