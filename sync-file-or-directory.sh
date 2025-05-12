#!/bin/bash
echo "Syncing the directory contents: "
sleep 1
echo "+++++++++++++++++++++++++++++++++"

sleep 1

rsync -e "ssh -p 2222" -avh --progress root@192.168.56.119:/abc/ /syncing

#For overall progress of the files...
#rsync -e "ssh -p 2222" -avh --info=progress2 root@192.168.56.119:/abc/ /syncing


#In this script, we are using rsync to sync files from a remote server (root@192.168.56.12) at port 2222 to a local directory (/syncing).

#The -e option specifies the remote shell to use (in this case, ssh with port 2222).
#The -a option enables archive mode, which preserves permissions, timestamps, symbolic links, and other file attributes.
#The -v option enables verbose output, and the -h option makes the output human-readable.
#The --progress option shows the progress of the transfer.

#The --info=progress2 option provides overall progress information for the transfer.