#!/bin/bash

data=$(zcat $1 | awk '{if(NR%4==2) print length($1)}' | sort -n | uniq -c)
echo $1 $data
