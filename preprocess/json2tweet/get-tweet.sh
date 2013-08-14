#!/bin/bash

unamestr=`uname`
if [[ "$unamestr" == "Linux" ]]; then
    arg=P
else
    arg=E
fi

for file in "$@"
do
  zcat $file | grep -o$arg '"truncated": [a-zA-Z]*, "text":.*?[^\\]",' | sed 's/"truncated": [a-zA-Z]*, "text": "\(.*\)",/\1/'
done
