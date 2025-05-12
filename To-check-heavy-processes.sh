#!/bin/bash

threshold=60.0

# Get the top 5 heavy processes by CPU usage
processes=$(ps -e -o cmd,%cpu --sort=-%cpu | head -6 | tail -n +2 )

for n in $processes
do
    cmd=$(echo "$n" | awk '{print $1}')
    cpu=$(echo "$n" | awk '{print $2}')

    if (( $(echo "$cpu >= $threshold" | bc) ))
    then
       echo -e "Process: $cmd, CPU usage: $cpu%" >> /root/cpu-reports.log
    fi
done

#bc (binary calculator) is a command-line calculator that supports arbitrary precision arithmetic.
# It is used here to compare floating-point numbers, as bash does not support floating-point arithmetic directly.