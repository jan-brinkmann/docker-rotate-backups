# docker-rotate-backups
This repository provides a Docker image that implements [`rotate-backups`](https://pypi.org/project/rotate-backups/).

By using this image, you are enabled to instantiate a container that runs `rotate-backups` once on a mounted directory. In the mounted directory, irrelevant backups are removed and useful are preserved. Afterwards, the container is stopped and, if desired, removed.

## How to use
We support running `rotate-backups` on both local and remote directories.

### Local Directories
Simply adapt the directory to mount at `/archive` and run the following command on your Docker host:
```
docker run --rm \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```

### Remote Directories
To run `rotate-backups` on a remote directory, adapt the variables `SSH_USER`, `SSH_HOST`, and `SSH_ARCHIVE`. You also need to mount your public SSH key to the named directory. Make sure, that you already have [exchanged keys with the remote host](https://foofunc.com/how-to-create-and-add-ssh-key-in-remote-ssh-server/).
```
docker run --rm \
-e SSH_USER=pi \
-e SSH_HOST=192.168.0.42 \
-e SSH_ARCHIVE=/path/to/backups \
-v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
ghcr.io/jan-brinkmann/docker-rotate-backups
```

## How to customize
The default scheme to preserve and to remove backups is `--hourly=0 --daily=7 --weekly=4 --monthly=12 --yearly=always --dry-run`. Due to the `--dry-run` flag, no backups will be removed. But you are allowed to customize the scheme.

### Scheme at once
You may overhand a complete scheme at once by means of `ROTATION_SCHEME`:
```
docker run --rm \
-e ROTATION_SCHEME="--daily=7 --weekly=4 --monthly=6" \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
For more information on the syntax and the options, we refer to the [official `rotate-backups` documentation](https://pypi.org/project/rotate-backups/#command-line).

### Configuration File
It is also possible to overhand a scheme within a configuration file `rotate-backups.ini`:
```
docker run --rm \
-v /path/to/backups:/archive \
-v /path/to/rotate-backups.ini:/config/rotate-backups.ini \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
In order to find out how to create such a file, we again refer to the [documentation](https://pypi.org/project/rotate-backups/#configuration-files).

### Separate Variables
The scheme can also be customized by a number of environmental variables representing various time spans:
Variable | Default Value | Possible Values | Notes
--- | --- | --- | ---
`HOURLY` | `0` | any integer, `always` | Number of hourly backups to preserve.
`DAILY` | `7` | any integer, `always` | Number of daily backups to preserve.
`WEEKLY` | `4` | any integer, `always` | Number of weekly backups to preserve.
`MONTHLY` | `12` | any integer, `always` | Number of monthly backups to preserve.
`YEARLY` | `always` | any integer, `always` | Number of yearly backups to preserve.
`DRY_RUN` | `true` | `true`, `false` | The dry-run option must explicitly be deactivated by means of `DRY_RUN=false` in order to remove backups.

Feel free to customize the variables you like to adapt only. In the following example, `DAILY`, `WEEKLY`, `MONTHLY`, and `DRY_RUN` are set to the respective values. `HOURLY` and `YEARLY` remain on the default values `0` and `always`, respectively. The resulting scheme is `--hourly=0 --daily=3 --weekly=1 --monthly=1 --yearly=always`.
```
docker run --rm \
-e DAILY=3 \
-e WEEKLY=1 \
-e MONTHLY=1 \
-e DRY_RUN=false \
-v /path/to/backups:/archive \
ghcr.io/jan-brinkmann/docker-rotate-backups
```
