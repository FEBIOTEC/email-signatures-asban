#!/usr/bin/env bash

PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")/../" &>/dev/null && pwd)"

# Substitute each mark by its value using indirect expansion
marks=["NAME" "PHONE" "IPHONE" "EMAIL"]
for i in ${PROJECT_FOLDER}/data; do
  initial="$(echo "${i}" | rev | cut -d "." -f1- | rev)"
  for mark in ${marks[@]}; do
    mark_name="${initial}_${mark}"
    mark_value=${!mark_name}
    sed -i "s/{{${mark_name}}}/${mark_value}/g" "${PROJECT_FOLDER}/data/${i}"
  done
done
