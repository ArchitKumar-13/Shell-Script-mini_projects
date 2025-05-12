#!/bin/bash
read -p "Enter the package to be searched: " P

if [ `rpm -q "$P"` ] > /dev/null 2>&1
then
    echo "$P package is installed"
else
    echo "$P package is not installed"

    sleep 3

    echo "...Package installing..."
    echo " `yum install -y $P` " > /dev/null 2>&1
    echo "!!!...Package Successfully installed...!!!"
fi