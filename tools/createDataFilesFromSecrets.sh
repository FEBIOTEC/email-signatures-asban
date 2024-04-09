#!/usr/bin/env bash

PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")/../" &>/dev/null && pwd)"

declare -A signature_names

# Path to the file
file="${PROJECT_FOLDER}/secrets/secrets.txt"

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "File not found: $file"
  exit 1
fi

# Open the file for reading
while IFS= read -r line; do
  signature_names["$(echo "${line}" | cut -d "=" -f1 | cut -d "_" -f1 | tr '[:upper:]' '[:lower:]')"]=""
done < "$file"

# Create data files
for key in "${!array[@]}"
do
  cp "${PROJECT_FOLDER}/templates/data.json" "${PROJECT_FOLDER}/templates/${key}.json"
done