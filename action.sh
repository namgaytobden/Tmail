#!/bin/bash

# Fetch environment variables
FROM_EMAIL="${FROM_EMAIL}"
FROM_NAME="${FROM_NAME}"
SMTP_URL="${SMTP_URL}"
SMTP_PASS="${SMTP_PASS}"
TO_EMAIL="${TO_EMAIL}"
SUBJECT="${SUBJECT}"
MAIL="${MAIL}"
CC="${CC}"
EMAIL_FILE="${EMAIL_FILE}"
ATTACHMENT="report_html.html"

# Define the path to the .muttrc file
MUTTRC_FILE="$HOME/.muttrc"

# Create or overwrite the .muttrc file with the nereport_html.html w settings
touch $MUTTRC_FILE
cat <<EOL > "$MUTTRC_FILE"
set from = "$FROM_EMAIL"
set realname = "$FROM_NAME"
set smtp_url = "$SMTP_URL"
set smtp_pass = "$SMTP_PASS"
EOL

echo ".muttrc file has been updated successfully."

source $MUTTRC_FILE

# Compose the mutt command
mutt_command="mutt -e "set content_type=text/html" -s $SUBJECT -i $ATTACHMENT"

# Add CC if provided
if [ -n "$CC" ]; then
  mutt_command="$mutt_command -c '$CC'"
fi


# Add the body or file
if [ -n "$MAIL" ]; then
  echo "$MAIL" | eval $mutt_command -- "$TO_EMAIL"
elif [ -n "$EMAIL_FILE" ]; then
  eval $mutt_command -- "$TO_EMAIL" < "$EMAIL_FILE"
else
  echo "No email body or file provided."
  exit 1
fi

echo "Email sent successfully."
