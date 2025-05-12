#!/bin/bash

large_files=false

# Find and compress log files greater than or equal to 1GB
#size of 1GB to 1KB (1 * 1024 * 1024 = 1048576)

for n in /var/log/abc/*.log
do
        # Skip if no files match the pattern
        [ -f "$n" ] || continue

        # Get file size in KB
        size_kb=$(du -k "$n" | cut -f1)

        if [ "$size_kb" -ge 1048576 ]
        then
                large_files=true
                #gzip -c "$n"
        
                #Best method, as it will maintain the original and compressed file
                gzip -c "$n" > "$n.gz"
                rm -rf "$n"
        fi
done

if [ "$large_files" = false ]
then
        echo "No file present greater than 1GB"
fi
echo "Compression process completed."

# Q: Compress the logs which are greater than or equal to 1GB and present in /var/log/abc/ directory