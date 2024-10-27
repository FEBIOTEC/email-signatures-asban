#!/usr/bin/env bash
#
# email-signatures-asban is a live repository that contains the necessary data and code to automate the generation of
# the email signatures from ASBAN email accounts.
#
# Copyright (C) 2024 - present @ Aleix Mariné-Tena (github.com/AleixMT)
#
# email-signatures-asban is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

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
for key in "${!signature_names[@]}"
do
  cp "${PROJECT_FOLDER}/templates/data.json" "${PROJECT_FOLDER}/data/${key}.json"
done