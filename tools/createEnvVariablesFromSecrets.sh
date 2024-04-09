#!/usr/bin/env bash

PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")/../" &>/dev/null && pwd)"

# Path to the file
file="${PROJECT_FOLDER}/secrets/secrets.txt"

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "File not found: $file"
  exit 1
fi

# Open the file for reading
env_var=""
while IFS= read -r line; do
  env_var="  $(echo "${line}" | cut -d "=" -f1): \${{ secrets.$(echo "${line}" | cut -d "=" -f1) }}
${env_var}"
done < "$file"

echo "Copy this variables into the env section of the workflow of this repository"
echo "${env_var}"

echo "${env_var}" > "${PROJECT_FOLDER}/.env"