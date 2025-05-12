#!/bin/bash

# Number of top-level directories
for n in {1..5}
do
    nested_path="./$n"

    # Create 13 nested "directory" levels
    for m in {1..10}
    do
        nested_path="$nested_path/directory"
    done

    mkdir -p "$nested_path"
done
