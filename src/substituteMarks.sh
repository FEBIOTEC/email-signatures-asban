#!/usr/bin/env bash

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
      awk -v search="{{${mark_name}}}" -v replacement="${mark_value}" '{gsub(search, replacement)} 1' "${PROJECT_FOLDER}/data/${i}.json" > "${PROJECT_FOLDER}/data/${i}.json.tmp" && mv "${PROJECT_FOLDER}/data/${i}.json.tmp" "${PROJECT_FOLDER}/data/${i}.json"
    fi
  done
done
