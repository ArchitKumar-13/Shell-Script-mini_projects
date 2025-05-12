#!/bin/bash

# Creating the backup of /etc directory in /back directory

tar -caf /back/etc-$(date +"%F %T").tar.gz /etc >> /dev/null

# Creating the logs in the backup.txt file, in the root's home (~) directory

if [ $? -eq 0 ]
then
        echo "Logs generated successfully on $(date)" >> /root/backup.txt
else
        echo "Logs failed on $(date)" >> /root/backup.txt
fi
