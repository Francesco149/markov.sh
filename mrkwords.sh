#!/bin/sh

file="${1:-~/.mrkdb}"
n="${2:-1}"
key="$3"
[ ! -z "$key" ] && echo "$key"
[ "$n" -le 0 ] && exit
if [ -z "$key" ]; then
  word=$(shuf -n 1 < "$file" | cut -d' ' -f1)
else
  word=$(grep -Fw "$key" < "$file" |
    awk -v key="$key" '$1 == key { print $2 }' < "$file" |
    shuf -n 1) || exit
  [ -z "$word" ] && exit
fi
exec "$0" "$file" "$(( n - 1 ))" "$word"
