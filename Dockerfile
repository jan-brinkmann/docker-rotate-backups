FROM python:3.10.1-alpine3.15

RUN pip install rotate-backups

COPY src/entrypoint.sh /home/entrypoint.sh

ENTRYPOINT ["sh", "/home/entrypoint.sh"]
