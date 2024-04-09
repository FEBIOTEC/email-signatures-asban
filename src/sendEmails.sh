#!/usr/bin/env bash

PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")/../" &>/dev/null && pwd)"


for signature in $@; do
  pointer="$(echo "${signature}" | tr '[:lower:]' '[:upper:]')_EMAIL"
  email_value="${!pointer}"
  echo   curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd --mail-from "${EMAIL_USERNAME}"  --mail-rcpt "${email_value}"  --user "${EMAIL_USERNAME}:${EMAIL_PASSWORD}"  --upload-file "${PROJECT_FOLDER}/out/${signature}.html"
  curl --url 'smtps://smtp.gmail.com:465' \
    --ssl-reqd \
    --mail-from "${EMAIL_USERNAME}" \
    --mail-rcpt "${email_value}" \
    --user "${EMAIL_USERNAME}:${EMAIL_PASSWORD}" \
    -T "${PROJECT_FOLDER}/out/${signature}.html"
done