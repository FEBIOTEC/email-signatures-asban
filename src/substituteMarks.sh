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

# Substitute each mark by its value using indirect expansion
marks=("NAME" "EMAIL" "POSITION" "LINKEDIN")
for i in $@; do
  initial="$(echo "${PROJECT_FOLDER}/data/${i}" | rev | cut -d "/" -f1 | cut -d "." -f2- | tr '[:lower:]' '[:upper:]' | rev)"
  for mark in ${marks[@]}; do
    mark_name="${initial}_${mark}"
    mark_value=${!mark_name}
    if [ -n "${mark_value}" ]; then
      echo "Substituted ${mark_name}"
      awk -v search="{{${mark}}}" -v replacement="${mark_value}" '{gsub(search, replacement)} 1' "${PROJECT_FOLDER}/data/${i}.json" > "${PROJECT_FOLDER}/data/${i}.json.tmp" && mv "${PROJECT_FOLDER}/data/${i}.json.tmp" "${PROJECT_FOLDER}/data/${i}.json"
    fi
  done
done
