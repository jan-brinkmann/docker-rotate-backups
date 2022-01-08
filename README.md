# docker-rotate-backups
This repository provides a Docker image that implements [`rotate-backups`](https://pypi.org/project/rotate-backups/).

By using this image, you are enabled to instantiate a container that runs rotate-backups once on a mounted directory. In the mounted directory, irrelevant backups are removed and useful are preserved. Afterwards, the container is stopped and, if desired, removed.

## How to use
Simply adapt the directory to mount and run the following command on your Docker host:
```
docker run --rm \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
The default scheme to preserve and to remove backups is `--daily=7 --weekly=4 --monthly=12 --yearly=always --dry-run`.

## How to customize
The scheme can be customized by means of `ROTATION_SCHEME`:
```
docker run --rm \
-e ROTATION_SCHEME="--daily=7 --weekly=4 --monthly=6" \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
For more information on the synthax and the options, we refer to the [official `rotate-backups` documentation](https://pypi.org/project/rotate-backups/#command-line).
