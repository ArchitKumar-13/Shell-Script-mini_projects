#!/bin/bash

user=$(whoami)
currentdate=$(date)
path=$(pwd)

echo "You are currently logged in as: $user and you are in the directory $path"
echo "Today is $currentdate"
