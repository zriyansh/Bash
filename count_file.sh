# exactly one argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory=$1

#directory exists 
if [ ! -d "$directory" ] || [ ! -r "$directory" ]; then
    echo "Error: Directory does not exist or is not readable"
    exit 1
fi

# Traverse
declare -A file_types

while IFS= read -r -d '' file; do
    ext="${file##*.}"
    if [ "$ext" != "$file" ]; then
        file_types["$ext"]=$((file_types["$ext"] + 1))
    else
        file_types["no_extension"]=$((file_types["no_extension"] + 1))
    fi
done < <(find "$directory" -type f -print0)

# display sorted list 
for ext in "${!file_types[@]}"; do
    echo "$ext: ${file_types[$ext]}"
done | sort

exit 0
