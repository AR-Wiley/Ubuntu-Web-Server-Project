#!/bin/bash

Avail-Memory() {

        dir_path="/var/log/admin-logs/"
        file_path="/var/log/admin-logs/memory-usage.txt"

        if [[ ! -d $dir_path ]]; then
                mkdir -p $dir_path
                echo "$dir_path has been created"
        fi

        if [[ ! -f $file_path ]]; then
                touch $file_path
                echo "$file_path has been created"
        fi

        timestamp() {
                date '+%Y-%m-%d %H:%M:%S'
        }


        AVAIL=$(free -m | awk 'NR==2 {print $7}')
        MINIMIUM=1024

        if (( AVAIL < MINIMIUM )); then
                echo "ALERT. FREE AVAILABLE RAM SPACE: $AVIAL IS BELOW MINIMUM THRESHOLD: $MINIMIUM" >> "$file_path"
        fi

        free -m >> "$file_path"

        echo "$(timestamp)" >> "$file_path"

}

Avail-Memory





