#!/usr/bin/env bash

PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")/../" &>/dev/null && pwd)"

env

# Substitute each mark by its value using indirect expansion
marks=("NAME" "EMAIL" "POSITION" "LINKEDIN")
for i in $@; do
  initial="$(echo "${PROJECT_FOLDER}/data/${i}" | rev | cut -d "/" -f1 | cut -d "." -f2-)"
  for mark in ${marks[@]}; do
    mark_name="$(echo "${initial}" | tr '[:lower:]' '[:upper:]')_${mark}"
    mark_value=${!mark_name}
    if [ -n "${mark_value}" ]; then
      echo "Substituted ${mark_name}"
      sed -i "s/{{${mark_name}}}/${mark_value}/g" "${PROJECT_FOLDER}/data/${i}"
    fi
  done
done
