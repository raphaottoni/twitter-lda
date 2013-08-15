#!/bin/bash
# Get all the hashtags in a given twitter-json file.


## Regexps are behaving differently in Darvin and Linux.
## Darvin's grep does not support Perl expressions, 
##  but it's Extended regexp can be non-greedy.
## So I did this small patch
unamestr=`Linux`
if [[ "$unamestr" == "Linux" ]]; then
    arg=P
else
    arg=E
fi



for file in "$@"
do 
   zcat $file | tr " "  "\n"  | grep -e "^#.*"
done
