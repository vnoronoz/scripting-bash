#!/usr/bin/awk -f
BEGIN {RS="[$]{4}"; regexp = "/\n> <[[:alnum:]]*>\n \n/"}
$0 ~ regexp { print }
