#!/usr/bin/env bash

PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")/../" &>/dev/null && pwd)"

set_secret()
{
  gh secret set "$1" --body "$2" --repository ASBTEC/email-signatures-asbtec
}

# Path to the file
file="${PROJECT_FOLDER}/secrets/secrets.txt"

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "File not found: $file"
  exit 1
fi

# Open the file for reading
while IFS= read -r line; do
  secret_name="$(echo "${line}" | cut -d "=" -f1)"
  secret_content="$(echo "${line}" | cut -d "=" -f2- | sed 's/"*$//g')"
  set_secret "${secret_name}" "${secret_content}"
done < "$file"