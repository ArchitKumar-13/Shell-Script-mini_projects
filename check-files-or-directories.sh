#!/bin/bash

for n in $(ls)
do
        if [ -d $n ]
        then
                echo "$n is a directory"
        else
                echo "$n is a file"
        fi
done
# This script lists all files and directories in the current directory and indicates whether each is a file or a directory.