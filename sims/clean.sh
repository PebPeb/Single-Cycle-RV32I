#!/bin/bash

for dir in */; do
    if [ -f "$dir/Makefile" ]; then
        echo "Cleaning $dir"
        (cd "$dir" && make clean)
    else
        echo "Skipping $dir (no Makefile found)"
    fi
done
