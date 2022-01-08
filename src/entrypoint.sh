#!/bin/sh

set -e

if [ -z $ROTATION_SCHEME ]; then
  ROTATION_SCHEME="--daily=7 --weekly=4 --monthly=12 --yearly=always --dry-run"
fi

/usr/local/bin/rotate-backups $ROTATION_SCHEME /archive
