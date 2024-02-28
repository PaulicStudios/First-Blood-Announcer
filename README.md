# CTFd First Blood Announcer

Continually monitor a CTFd instance and announce first bloods to a Discord channel via webhook.

By default, skips first bloods achieved before the script was run but can be configured to announce the existing as well.

## Usage

```
Usage: python first-blood-announcer.py [-h] [--webhook WEBHOOK] [--ctfd CTFD] [--token TOKEN] [--existing] [--interval INTERVAL]

Announce CTF first bloods from CTFd on Discord

options:
  -h, --help           Show this help message and exit
  --webhook WEBHOOK    Discord webhook URL
  --ctfd CTFD          CTFd URL
  --token TOKEN        CTFd Access Token
  --existing           Announce existing solves
  --interval INTERVAL  Refresh interval in seconds (default: 5)
```

Requires a CTFd URL, an active CTFd access token, and a Discord webhook to send the announcements to.
Use command line options or the environment variables `WEBHOOK_URL`, `CTFD_URL`, and `CTFD_ACCESS_TOKEN` - possibly in a `.env` file.

## Setup

The script requires Python 3 and uses a single (very common) external dependency:

```
pip install requests
```

Then simply run with

```
python first-blood-announcer.py [OPTIONS]
```

To create a Discord webhook URL, go to `Server Settings` -> `Integrations` -> `Webhooks` -> `New Webhook`.
Choose a name (shows up as the sender of each announcement) and set the channel for the messages. Then copy the webhook URL.

To create a CTFd access token, make a profile on the CTFd instance, choose `Settings` -> `Access Tokens`, click `Generate` and copy the token.
**Note:** The script can see the same challenges as the user creating the token.
Any user can create a token, but if a challenge is locked behind another, the script cannot see it before the user has unlocked it.
