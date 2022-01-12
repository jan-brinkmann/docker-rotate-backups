#!/bin/sh

set -e

if [ -f "rotate-backups.ini" ]; then
   ROTATION_SCHEME="-c rotate-backups.ini"
fi

HOURLY="${HOURLY:-0}"
DAILY="${DAILY:-7}"
WEEKLY="${WEEKLY:-4}"
MONTHLY="${MONTHLY:-12}"
YEARLY="${YEARLY:-always}"
DRY_RUN="${DRY_RUN:-true}"

if [ -z $ROTATION_SCHEME ]; then
  ROTATION_SCHEME="--hourly=$HOURLY --daily=$DAILY --weekly=$WEEKLY --monthly=$MONTHLY --yearly=$YEARLY"
  if [ $DRY_RUN != false ]; then
    ROTATION_SCHEME="$ROTATION_SCHEME --dry-run"
  fi
fi

echo -e "\n\033[1m[INFO] rotate-backups \033[0m \n"
echo "ROTATION_SCHEME: $ROTATION_SCHEME"

/usr/local/bin/rotate-backups $ROTATION_SCHEME /archive
