#!/usr/bin/awk -f
BEGIN {RS="[$]{4}"}
{if (NR==num) print}
