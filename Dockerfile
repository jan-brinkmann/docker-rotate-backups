FROM python:3.7.10-alpine3.12

MAINTAINER Jan Brinkmann

RUN apk update && apk add openssh-client

RUN pip install rotate-backups==8.1

COPY src/entrypoint.sh /home/entrypoint.sh

ENTRYPOINT ["sh", "/home/entrypoint.sh"]
