# docker-rotate-backups
This repository provides a Docker image that implements [`rotate-backups`](https://pypi.org/project/rotate-backups/).

By using this image, you are enabled to instantiate a container that runs `rotate-backups` once on a mounted directory. In the mounted directory, irrelevant backups are removed and useful are preserved. Afterwards, the container is stopped and, if desired, removed.

## How to use
Simply adapt the directory to mount and run the following command on your Docker host:
```
docker run --rm \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
The default scheme to preserve and to remove backups is `--hourly=0 --daily=7 --weekly=4 --monthly=12 --yearly=always --dry-run`.

## How to customize
The scheme can be customized by the environmental variables `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`, `YEARLY`, and `DRY_RUN`. Feel free to customize the variables you like to adapt only. In the following example, `DAILY`, `WEEKLY`, `MONTHLY`, and `DRY_RUN` are set to the respective values. `HOURLY` and `YEARLY` remain on `0` and `always`, respectively. The resulting scheme is `--hourly=0 --daily=3 --weekly=1 --monthly=1 --yearly=always`.
```
docker run --rm \
-e DAILY=3 \
-e WEEKLY=1 \
-e MONTHLY=1 \
-e DRY_RUN=false \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
Otherwise, you are enabled to overhand a complete schema at once by means of `ROTATION_SCHEME`:
```
docker run --rm \
-e ROTATION_SCHEME="--daily=7 --weekly=4 --monthly=6" \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
For more information on the syntax and the options, we refer to the [official `rotate-backups` documentation](https://pypi.org/project/rotate-backups/#command-line).
