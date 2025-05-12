#!/bin/bash

for i in `docker ps -a -q`
do
        echo $(docker rm -f $i)
done
