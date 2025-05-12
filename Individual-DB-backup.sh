#!/bin/bash

read -p "Type (go) to check, if there is mariadb package present: " P

if [ $P == "go" ]
then
        mariadb_status=$(rpm -q mariadb)

        if [ $mariadb_status != true ] 2> /dev/null
        then
                echo "Perfect, package is already present!!!"

                #check the service of the mariadb
                systemctl is-enabled mariadb >> /dev/null
                if [ $? -ne 0 ]
                then
                        echo "Enabling and starting the service"
                        systemctl enable --now mariadb
                else
                        echo "Service already enabled"
                fi

        else
                echo "package is not installed :("

                echo "Package installing..."
                dnf install -y mariadb &> /dev/null

                echo "Service is enabled and running"
                systemctl enable --now mariadb

                echo "!!!...Package Successfully installed and is up...!!!"
        fi
fi

echo -e "\nHere are the list of DBs: "
echo "##########################"
echo "show databases" | mysql | tail -n +2
echo -e "########################## \n"

#read -p "Enter the DB to be backed-up: " db

#List of databases
databases=$(echo "show databases" | mysql | tail -n +2)

#where you want to save the backup
read -p "Enter the specified directory: " dir

for n in $databases
do
        if [ ! -d "$dir" ]
        then
                mkdir -p $dir
        else
                # mysqldump $n > $dir/$n.sql 2> /dev/null

                # Compressed backups are better for space....
                mysqldump $n 2>/dev/null | gzip > $dir/$n-$(date +%F).sql.gz
        fi
done