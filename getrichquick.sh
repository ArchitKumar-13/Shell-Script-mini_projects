#!/bin/bash

echo "What is your name?"
read name
# read -p "Whats your name? " name

echo "What is your age?"
read age

echo "Hello $name, you are $age years old."

sleep 2

echo "Calculating..."
sleep 1
echo ".........."
sleep 1
echo "*........."
sleep 1
echo "***......."
sleep 1
echo "*****....."
sleep 1
echo "********.."
sleep 1
echo "**********"
sleep 1

getrich=$((( $RANDOM % 15 ) + $age ))

echo "$name, you'll be a Millionaire at the age of: $getrich"
