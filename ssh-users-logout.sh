#!/bin/bash

read -p "Type (go) to check, if there is postfix package present, to mail reports to root: " P

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

while :
do
        for n in $(w | tail -n +3 | grep -v root | awk '{print $1}')
        do
                TSK=(w | grep $n | awk '{print $2}')
                PID=`ps -eo pid,cmd | grep $TSK | awk '{print $1}'`
                kill $PID >> /dev/null
                echo "user $n was illegally trying to login at $(date) | mail -s "Security issue" root@abc.com"
        done
done

# This script checks for users logged in via SSH and kills their sessions if they are not root.
# It also sends an email to the root user with a report of the action taken on those users who are trying to
# ssh into the server.