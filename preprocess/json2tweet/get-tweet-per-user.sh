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
  ./get-tweet.sh $input/$file | gzip > $output/$file
done
