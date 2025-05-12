#!/bin/bash

# Find and compress log files greater than or equal to 1GB
# Size of 1GB in KB (1 * 1024 * 1024 = 1048576)
for n in /var/log/abc/*.log
do
    # Get file size in KB
    size_kb=$(du -k "$n" | cut -f1)

    if [ "$size_kb" -ge 1048576 ]
    then
        #gzip -c "$n"

        #Best method, as it will maintain the original and compressed file
        gzip -c "$n" > "$n.gz"
        rm -rf "$n"

    fi
done

echo "Compression process completed."

# Q: Compress the logs which are greater than or equal to 1GB and present in /var/log/abc/ directory
