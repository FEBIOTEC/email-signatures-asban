#!/usr/bin/env bash

PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")/../" &>/dev/null && pwd)"

# Substitute each mark by its value using indirect expansion
marks=("NAME" "EMAIL" "POSITION" "LINKEDIN")
for i in $@; do
  initial="$(echo "${PROJECT_FOLDER}/data/${i}" | rev | cut -d "/" -f1 | cut -d "." -f2- | tr '[:lower:]' '[:upper:]')"
  for mark in ${marks[@]}; do
    mark_name="${initial}_${mark}"
    echo mark_name is $mark_name
    mark_value=${!mark_name}
    if [ -n "${mark_value}" ]; then
      echo "Substituted ${mark_name}"
      sed -i "s/{{${mark_name}}}/${mark_value}/g" "${PROJECT_FOLDER}/data/${i}"
    fi
  done
done
