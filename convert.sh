#!/bin/bash

# Directory containing the files
DIR=$1

# Check if directory is provided
if [ -z "$DIR" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Loop through all files in the directory
for FILE in "$DIR"/*; do
  # Check if the file has a BOM
  if file "$FILE" | grep -q "Unicode text, UTF-8 (with BOM) text"; then
    # Create a new filename with a suffix
    NEWFILE="${FILE%.txt}_utf8.yml"
    # Convert the file to UTF-8 without BOM
    tail -c +4 "$FILE" > "$NEWFILE"
    echo "Converted $FILE to $NEWFILE"
  fi
done

