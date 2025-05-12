#!/bin/bash

for n in $(cat users.txt)
do
        if id "$n" &> /dev/null
        then
                echo "user $n already exists"
        else
                useradd "$n" &> /dev/null
                echo "test@123" | passwd --stdin $n > /dev/null
        fi
done

#All the users in (users.txt) file are created with the same password.
#Remember to make the users.txt file with the users you want to create.

# To delete the file users instantly, you can use the following command:
# for n in $(cat users.txt); do userdel -r $n; done