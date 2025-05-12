#!/bin/bash

for i in {1..5}
do
        mkdir -p "./$i/$(yes directory | head -9 | paste -sd/)"
done

# The above code creates 5 top-level directories, each containing 10 nested directories named "directory".

# The `mkdir -p` command creates the directories, and the `-p` option creates any necessary parent directories.
# The `yes` command generates an infinite stream of "directory" strings, and `head -9` limits it to 9 lines.
# The `head -9` command limits the output to 9 lines, which is used to create 10 nested directories.
# The `paste -sd/` command concatenates these lines into a single string separated by slashes, which is then used to create the nested directories.