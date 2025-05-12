#!/bin/bash

echo "Do you want to check the internet connectivity (yes/no): "
read Int

if [[ $Int == "yes"  ]]
then

        if ping -c 1 8.8.8.8 >> /dev/null
        then
                echo "Internet is connected..."
        else
                echo "No Connection..."
        fi

else
        echo "See you again..."
fi

<<COMMENT
Indentations are not mandatory, but it's good practice for readability.

what can be the requirement...
Go to the internet and download the package.
Go the gmail and mail to the user.

COMMENT

# ☝🏻...If we want to give multi-line comment in the shell scripting...☝🏻
