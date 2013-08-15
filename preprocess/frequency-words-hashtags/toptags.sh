#!/bin/bash
# Get the k most used hastags using 1 of 2 different methods.
#
# Given a directory with twitter json files, return the k most frequent hashtags.
# "Most frequent" can be defined as the ones that most appeared overall, or 
# the one that were used by the largest amount of users. 
#
# The script assumes that 
# 1) each user has a different file;
# 2) this file is compressed as a .gz;
# 3) all .gz in the directory are to be read.
#
## Usage:
## -k <int> : number of hashtags to be considered. Default: 99999
## -w: take the most widely used instead of the most frequently used
## -d: directory to look for the files.
## -h: where to store the raw hashtags. Default is in a buffer file which will be deleted

most_widely_used=false
path="."
amount=99999
buffer=htgs
delete_buffer=true

while getopts 'k:wd:h:' opt;  do
    case $opt in
	w)
	    most_widely_used=true
	    ;;
	k)
	    amount=$OPTARG
	    ;;
	d)
	    path=$OPTARG
	    ;;
	h) 
	    buffer=$OPTARG
	    delete_buffer=false
	    ;;
    esac
done 

if $most_widely_used; then 
    > $buffer #reset buffer if it exists
    for user in $(ls $path/*.gz); do
	./extract_hashtags.sh $user | sort | uniq >> $buffer
    done
else
    ./extract_hashtags.sh $(ls $path/*.gz) > $buffer
fi

sort $buffer | uniq -c | sort -r | head -n $amount

if $delete_buffer; then
    rm $buffer
fi


