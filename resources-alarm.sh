#!/bin/bash

read -p "Type (go) to check, if the postfix package is present, to mail the reports to root: " P

if [ $P == "go" ]
then
        postfix_status=$(rpm -q postfix)

        if [ $postfix_status != true ] 2> /dev/null
        then
                echo "Perfect, package is already present!!!"

                #check the service of the postfix
                systemctl is-enabled postfix
                if [ $? -ne 0 ]
                then
                        echo "Enabling and starting the service"
                        systemctl enable --now postfix
                else
                        echo "Service already enabled"
                fi

        else
                echo "package is not installed :("

                echo "Package installing..."
                dnf install -y postfix &> /dev/null

                echo "Service is enabled and running"
                systemctl enable --now postfix

                echo "!!!...Package Successfully installed and is up...!!!"
        fi
fi

#MEMORY USAGE REPORT...

used_mem=`free | head -2 | tail -1 | awk '{ print $3 }'`
total_mem=`head -1 /proc/meminfo | awk '{print $2}'`

mem_percentage=$(echo "your current used mem% is: `expr $used_mem \* 100 / $total_mem`%")

echo -e "`date +"%T %F"` \t $mem_percentage " >> /root/mem_report.tsv

#echo -e "`date +"%r %D"` \t $mem_percentage " >> /root/mem_report.tsv

if [[ $mem_percentage == "80" ]]
then
        echo -e "\033[1;31mALERT\033[1;00m MEMORY-OVERLOADING"
        echo -e "High Memory utilisation, Please check" | mail -s "System-OOM-alert" root@mymail.com
fi


#CPU USAGE REPORT...

threshold=60.0

cpu_usage=$(top -bn1 | head -8 | awk 'NR==8' | awk '{print $9}')

if (( $(echo "$cpu_usage >= $threshold" | bc) ))
then
        echo -e "`date +"%T %F"` High CPU utilisation detected: $cpu_usage" >> /root/cpu_report.tsv
        echo -e "\033[1;31mALERT\033[1;00m CPU-Overloading"
        echo -e "High CPU utilisation, Please check" | mail -s "CPU overload alert" root@mymail.com
fi


#STORAGE(/) USAGE REPORT...

disk_usage=`df -h | grep sda | awk '{print $5}' | cut -f1 -d '%'`

if [ $disk_usage -ge 20 ]
then
        echo -e "`date +"%T %F"` High disk usage detected: $disk_usage%" >> /root/storage-report.tsv
        echo -e "\033[1;31mALERT\033[1;00m Low-Disk-Space"
        echo -e "Low disk space, Please check" | mail -s "disk alert" root@mymail.com
fi