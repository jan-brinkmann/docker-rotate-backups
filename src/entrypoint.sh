#!/bin/sh

set -e

if [ -z $ROTATE_BACKUPS_CONFIG ]; then
  ROTATE_BACKUPS_CONFIG="--daily=7 --weekly=4 --monthly=12 --yearly=always --dry-run"
fi

/usr/local/bin/rotate-backups $ROTATE_BACKUPS_CONFIG /archive
