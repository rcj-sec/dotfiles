#!/bin/bash

# Usage check
if [ $# -ne 2 ]; then
    echo "Usage: find_java_class <base_dir> <fully.qualified.Class.method()>"
    exit 1
fi

base_dir="$1"
fq_method="${2%\(\)}"  # Strip trailing ()
class_path="${fq_method%.*}"
method_name="${fq_method##*.}"
class_name="${class_path##*.}"

# Search for the matching method
find "$base_dir" -name "$class_name.java" | while read -r file; do
    if grep -q "^[[:space:]]*.*[[:space:]]$method_name[[:space:]]*(" "$file"; then
        echo "$file"
        exit 0
    fi
done
