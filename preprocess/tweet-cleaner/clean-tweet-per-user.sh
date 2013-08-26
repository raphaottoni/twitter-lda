#!/bin/bash

while getopts 'i:o:' opt;  do
  case $opt in
    i)
        input=$OPTARG
        ;;
    o)
        output=$OPTARG
        ;;
  esac
done

for file in $(ls $input)
do
    echo -e $(zcat $input/$file | awk '{print tolower($0)}') | sed -e 's!http\(s\)\{0,1\}://[^[:space:]]*!!g;' | sed -e 's!@[^[:space:]]*!!g;' |   sed  -e "s/[^a-zA-Z0-9# ]//g"  | gzip > $output/$file
done
