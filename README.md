# CTFd First Blood Announcer

Continually monitor a CTFd instance and announce first bloods to a Discord channel via webhook.

By default, skips first bloods achieved before the script was run but can be configured to announce the existing as well.

## Usage

```
Usage: python first-blood-announcer.py [-h] [--webhook WEBHOOK] [--ctfd CTFD] [--token TOKEN] [--existing] [--interval INTERVAL] [--db DB]

Announce CTF first bloods from CTFd on Discord

options:
  -h, --help           Show this help message and exit
  --webhook WEBHOOK    Discord webhook URL
  --ctfd CTFD          CTFd URL
  --token TOKEN        CTFd Access Token
  --existing           Announce existing solves
  --interval INTERVAL  Refresh interval in seconds (default: 5)
  --db DB              Database path (default: solves.db)
```

Requires a CTFd URL, an active CTFd access token, and a Discord webhook to send the announcements to.
Can be set with command line options or the environment variables `WEBHOOK_URL`, `CTFD_URL`, and `CTFD_ACCESS_TOKEN` - optionally in a `.env` file.

An existing database can be specified with `--db`. If the file does not exist, a new database is created.

To change the announcement message, update the `ANNOUNCEMENT` constant in the top of the source code.
Use `{challenge}` and `{user}` where the challenge title and username should be inserted.

## Setup

The script requires Python 3 and uses a single (very common) external dependency:

```
pip install requests
```

Optionally install `dotenv` to automatically read environment variables from a .env-file:

```
pip install python-dotenv
```

Then simply run with

```
python first-blood-announcer.py [OPTIONS]
```

To create a Discord webhook URL, go to `Server Settings` -> `Integrations` -> `Webhooks` -> `New Webhook`.
Choose a name (shows up as the sender of each announcement) and set the channel for the messages. Then copy the webhook URL.

To create a CTFd access token, make a profile on the CTFd instance, click `Settings` -> `Access Tokens`, choose an expiration date, click `Generate`, and copy the token.

**Note:** The bot can see the same challenges as the user creating the token.
Any user can create a token, but if a challenge is locked behind another, the script cannot see it before the user has unlocked it.

## Docker Deployment

The application can be run in a Docker container. The following files are provided for Docker deployment:

### Using Docker Compose (Recommended)

1. Create a `.env` file with your configuration:

```
WEBHOOK_URL=https://discord.com/api/webhooks/your-webhook-url
CTFD_URL=https://your-ctfd-instance.com
CTFD_ACCESS_TOKEN=your-access-token
```

2. Start the container:
```
docker-compose up -d
```

The container will automatically restart unless explicitly stopped. View logs with:
```
docker-compose logs -f
```

### Manual Docker Setup

If you prefer to build and run the container manually:

1. Build the image:
```
docker build -t first-blood-announcer .
```

2. Run the container:
```
docker run -d \
  --name first-blood-announcer \
  -v ./data:/app/data \
  --env-file .env \
  --restart unless-stopped \
  first-blood-announcer
```

### Files

- `Dockerfile`: Defines the container image
- `docker-compose.yml`: Defines the service configuration
- `requirements.txt`: Lists Python dependencies
- `.env`: Contains environment variables (do not commit to version control)
- `data/`: Directory for persistent database storage (mounted as volume)

The SQLite database will be stored in the `data` directory, which persists across container restarts.
