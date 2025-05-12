#!/bin/bash

echo "-------LUCKY DRAW EVENT--------"

lucky_number=$(( $RANDOM % 2 ))

echo "Pick a number b/w (0-1) and try your luck..."
read customer_number

if [[ $lucky_number == $customer_number ]]
then
	echo "CONGRATULATIONS!!! You are lucky, and won this event..."
else
	echo "Try luck next time..."
fi
