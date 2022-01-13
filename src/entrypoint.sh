#!/bin/sh

set -e

if [ -f "/config/rotate-backups.ini" ]; then
   ROTATION_SCHEME="-c /config/rotate-backups.ini"
fi

HOURLY="${HOURLY:-0}"
DAILY="${DAILY:-7}"
WEEKLY="${WEEKLY:-4}"
MONTHLY="${MONTHLY:-12}"
YEARLY="${YEARLY:-always}"
DRY_RUN="${DRY_RUN:-true}"

# Set up rotation scheme
if [ -z $ROTATION_SCHEME ]; then
  ROTATION_SCHEME="--hourly=$HOURLY --daily=$DAILY --weekly=$WEEKLY --monthly=$MONTHLY --yearly=$YEARLY"
  if [ $DRY_RUN != false ]; then
    ROTATION_SCHEME="$ROTATION_SCHEME --dry-run"
  fi
fi

# Set up archive directory
if [ -f /root/.ssh/id_rsa ]; then
  ARCHIVE="$SSH_USER@$SSH_HOST:$SSH_ARCHIVE"
elif [ -d /archive ]; then
  ARCHIVE="/archive"
else
  echo "No archive directory found."
  exit 1
fi

echo -e "\n\033[1m[INFO] rotate-backups \033[0m \n"
echo "rotate-backups $ROTATION_SCHEME $ARCHIVE"

/usr/local/bin/rotate-backups $ROTATION_SCHEME $ARCHIVE
