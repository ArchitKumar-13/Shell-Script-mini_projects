#!/bin/bash

used_mem=`free -m | head -2 | tail -1 | awk '{ print $3 }'`
total_mem=`free -m | head -2 | tail -1 | awk '{ print $2 }'`

mem_percentage=$(echo "your current used mem% is: `expr $used_mem \* 100 / $total_mem`%")

echo -e "`date +"%T %F"` \t $mem_percentage " >> /root/mem_report.tsv

#echo -e "`date +"%r %D"` \t $mem_percentage " >> /root/mem_report.tsv
