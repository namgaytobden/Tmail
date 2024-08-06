#!/bin/bash

FROM_EMAIL="${FROM_EMAIL}"
FROM_NAME="${FROM_NAME}"
SMTP_URL="${SMTP_URL}"
SMTP_PASS="${SMTP_PASS}"
TO_EMAIL="${TO_EMAIL}"
SUBJECT="${SUBJECT}"
MAIL="${MAIL}"
CC="${CC}"
EMAIL_FILE="${EMAIL_FILE}"
ATTACHMENT="${ATTACHMENT}"

MUTTRC_FILE="$HOME/.muttrc"

touch $MUTTRC_FILE
cat <<EOL > "$MUTTRC_FILE"
set from = "$FROM_EMAIL"
set realname = "$FROM_NAME"
set smtp_url = "$SMTP_URL"
set smtp_pass = "$SMTP_PASS"
EOL

echo ".muttrc file has been updated successfully."

source $MUTTRC_FILE

mutt_command="mutt -s '$SUBJECT'"

if [ -n "$ATTACHMENT" ]; then
  mutt_command="$mutt_command -a '$ATTACHMENT'"
fi

if [ -n "$CC" ]; then
  mutt_command="$mutt_command -c '$CC'"
fi

if [ -n "$MAIL" ]; then
  echo "$MAIL" | eval $mutt_command -- "$TO_EMAIL"
elif [ -n "$EMAIL_FILE" ]; then
  eval $mutt_command -- "$TO_EMAIL" < "$EMAIL_FILE"
else
  echo "No email body or file provided."
  exit 1
fi

echo "Email sent successfully."
