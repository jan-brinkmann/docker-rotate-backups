# docker-rotate-backups
This repository provides a Docker image that implements [`rotate-backups`](https://pypi.org/project/rotate-backups/).

Using this image you are enabled to instantiate container that runs rotate-backups once on a mounted directory where your backups are stored. Afterwards, the container is stopped and, if desired, removed.

## How to use
Simply adapt the directory to mount and run the following command in your Docker host:
```
docker run --rm \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
The default schema to preserve and to remove backups is `--daily=7 --weekly=4 --monthly=12 --yearly=always --dry-run`.

## How to customize
The schema can be customized by means of `ROTATE_BACKUPS_CONFIG`:
```
docker run --rm \
-e ROTATE_BACKUPS_CONFIG="--daily=7 --weekly=4 --monthly=6" \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
For more information on the synthax and the option of the schema, we refer to the [official `rotate-backups` documentation](https://pypi.org/project/rotate-backups/#command-line).