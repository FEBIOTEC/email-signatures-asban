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

for signature in $@; do
  pointer="$(echo "${signature}" | tr '[:lower:]' '[:upper:]')_EMAIL"
  email_value="${!pointer}"

  curl -v --url 'smtps://smtp.gmail.com:465' \
    --ssl-reqd \
    --mail-from "${EMAIL_USERNAME}" \
    --mail-rcpt "${email_value}" \
    --mail-rcpt "${EMAIL_USERNAME}" \
    --user "${EMAIL_USERNAME}:${EMAIL_PASSWORD}" \
    -F '=(;type=multipart/mixed' \
    -F "=¡Hola!

Estás recibiendo este correo porque se ha generado una nueva firma para el email de ASBTEC ${email_value}. Descarga el archivo adjunto de este correo y actualiza tu firma a tu cliente de correo electrónico.

Si has recibido más de un correo de este tipo utiliza el contenido del último mail para actualizar la firma, pues será la versión más actualizada. Puedes borrar el resto.

En este vídeo podrás encontrar instrucciones sobre cómo instalar la firma en tu cuenta de correo de ASBAN: https://youtu.be/v4Mi0DMAwQU. Recuerda que sólo podrás ver el vídeo si estás logueado en YouTube con tu cuenta de ASBAN.

Este mensaje ha sido autogenerado. Por cualquier problema contacta con informatica@asbtec.cat.

¡Hasta pronto!

Aleix
;type=text/plain" \
    -F "file=@${PROJECT_FOLDER}/out/${signature}.html;type=text/html;encoder=base64" \
    -F '=)' \
    -H "Subject: Actualización de firmas de email" \
    -H "From: Informàtica ASBTEC <informatica@asbtec.cat>" \
    -H "To: ${EMAIL_USERNAME} <${EMAIL_USERNAME}>"
done