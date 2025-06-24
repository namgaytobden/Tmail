# Terminal Mail

## Overview of Mutt

Mutt is a powerful and highly configurable command-line email client for Unix-like systems. It supports various email protocols such as IMAP, POP3, and SMTP. Mutt is often used for reading and sending emails directly from the terminal, making it a popular choice for users who prefer command-line interfaces or need to automate email sending in scripts.

## Using Tmail to Send Emails

To send an email with Tmail Action, you need to generate password from you google account and add other Environments as github secrets. Also you need to specify various options such as the subject, recipients, body and attachments.

**Note**: Tmail currently only supports sending emails via Gmail's SMTP server. To use Gmail for sending emails, you need to generate an **App Password from your Google account.** 

### Generating an App Password

1. Go to your [Google Account](https://myaccount.google.com/).
2. Navigate to **Security**.
3. Under **"Signing in to Google"**, select **App passwords**.
4. You may need to sign in again to verify your identity.
5. Choose **Mail** as the app and **Other** for the device. Enter a name for the password, then click **Generate**.
6. Copy the generated app password and use it as `SMTP_PASS` in your environment variables.

For detailed instructions, you can also refer to this [Gmail SMTP password generation tutorial](https://www.gmass.co/blog/gmail-smtp/).

## Script Overview

This script demonstrates how an email is sent by using Tmail Action:

1. **Fetching Configuration Details**: The script retrieves email configuration details from environment variables.
2. **Configuring `.muttrc`**: It sets up the `.muttrc` configuration file with the provided email settings, including sender details and SMTP server configuration.
3. **Composing the Email**: It constructs the `mutt` command to send the email with optional CC and attachments.
4. **Sending the Email**: Depending on the provided options, the script sends the email with either the body content directly or from a file, and attaches files if specified.

## Environment Variables

### Github Secrets
| Variable      | Description                                           | Example                                  |
|---------------|-------------------------------------------------------|------------------------------------------|
| `FROM_EMAIL`  | Email address from which the email will be sent.  | `yourmail@gmail.com`                     |
| `FROM_NAME`   | Name that will appear as the sender.              | `Sender Name`                            |
| `SMTP_URL`    | URL of the SMTP server used to send the email.    | `smtp://<youremail>@smtp.gmail.com:587/` |
| `SMTP_PASS`   | Password for the SMTP server.                     | `Password_Generated_from_google_account` |

### User Input
| Variable       | Description                                              | Example                        |
|----------------|----------------------------------------------------------|--------------------------------|
| `TO_EMAIL`     | Email address of the recipient.                      | `recipient@example.com`        |
| `SUBJECT`      | Subject of the email.                                | `Subject Subject`              |
| `MAIL`         | Body content of the email (optional).                | `Email Body.`                  |
| `CC`           | Email address for CC (optional).                     | `cc@example.com`               |
| `EMAIL_FILE`   | Path to a file containing the email body (optional). | `/path/to/email_body.txt`      |
| `ATTACHMENT`   | Path to a file to be attached to the email (optional). | `/path/to/attachment.txt`      |

## Using Tmail Action

**Set Environment Variables**: Ensure the required environment variables are set. For security, sensitive information like `FROM_EMAIL`, `FROM_NAME`, `SMTP_URL`, and `SMTP_PASS` should be added as secrets in you Github repository.

```yaml
- name: Tmail 
  uses: namgaytobden/Tmail@master
  with:
    #Github Secrets 
    fromEmail: ${{ secrets.FROM_EMAIL }}
    fromName: ${{ secrets.FROM_NAME }}
    smtpUrl: ${{ secrets.SMTP_URL }}
    smtpPass: ${{ secrets.SMTP_PASS }}
  
    #User Input
    toEmail: 'email@gmail.com'
    subject: 'Your subject here'
    attachment: 'path/to/your/file'

    cc: 'email2@gmail.com'
    mail: |
        Your email body 
```
