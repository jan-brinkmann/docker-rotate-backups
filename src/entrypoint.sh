#!/bin/sh

set -e

echo -e "\n\033[1m[INFO] rotate-backups \033[0m \n"

# Load custom or default values for the rotation scheme
HOURLY="${HOURLY:-0}"
DAILY="${DAILY:-7}"
WEEKLY="${WEEKLY:-4}"
MONTHLY="${MONTHLY:-12}"
YEARLY="${YEARLY:-always}"
DRY_RUN="${DRY_RUN:-true}"

# Load configuration file
if [ -f "/config/rotate-backups.ini" ]; then
   ROTATION_SCHEME="-c /config/rotate-backups.ini"
fi

# Set up rotation scheme
if [ -z $ROTATION_SCHEME ]; then
  ROTATION_SCHEME="--daily=$DAILY --weekly=$WEEKLY --monthly=$MONTHLY --yearly=$YEARLY"
  if [ $HOURLY != 0 ]; then
    ROTATION_SCHEME="--hourly=$HOURLY $ROTATION_SCHEME"
  fi
  if [ $DRY_RUN != false ]; then
    ROTATION_SCHEME="$ROTATION_SCHEME --dry-run"
  fi
fi

# Set up archive
if [ -f /root/.ssh/id_rsa ] && [ ! -z $SSH_USER ] && [ ! -z $SSH_HOST ] && [ ! -z $SSH_ARCHIVE ]; then
  ARCHIVE="$SSH_USER@$SSH_HOST:$SSH_ARCHIVE"
elif [ -d /archive ]; then
  ARCHIVE="/archive"
else
  echo "No archive directory found."
  exit 1
fi

# Run rotate-backups
echo "rotate-backups $ROTATION_SCHEME $ARCHIVE"
/usr/local/bin/rotate-backups $ROTATION_SCHEME $ARCHIVE
