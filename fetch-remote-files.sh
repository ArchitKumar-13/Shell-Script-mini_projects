#!/bin/bash

read -p "Enter the user of the server: " user
read -p "Enter the IP of the server: " IP
read -p "Enter the directory path to download the files: " fd

for n in $(cat path.txt)
do
        if [ -n "fd" ]
        then
                rsync -avPh $user@$IP:$n $fd
        fi
done

# The script prompts the user for the server's user, IP address, and the directory path to download the files,
# and will read the paths from path.txt file and download them to the specified directory.

# The rsync command is used to synchronize files and directories between two locations.
# The -a option enables archive mode, which preserves permissions, timestamps, symbolic links, and other file attributes.
# The -v option enables verbose output, and the -P option shows progress during the transfer.
# The -h option makes the output human-readable.