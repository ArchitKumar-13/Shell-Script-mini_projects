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

read -p "Enter the DB to be backed-up: " db

#List of databases
databases=$(echo "show databases" | mysql | tail -n +2)

#flag to find db is present or not
db_found=false

#read -p "Enter your directory, to store the db-backup: " dir

for n in $databases
do

            if [ "$db" == "$n" ]
            then
                    db_found=true
                    #mysqldump $db > /root/$db.sql

                    # Compressed backups are better for space....
                    mysqldump $db 2>/dev/null | gzip > /root/$db-$(date +%F).sql.gz
            fi

                if [ $? -eq 0 ]
                then
                        echo "Backup taken successfully"
                fi
                break
done

if [ $db_found = false ]
then
        echo "DB not found"
fi
