FROM python:3.7-alpine3.12

RUN pip install rotate-backups

COPY src/entrypoint.sh /home/entrypoint.sh

ENTRYPOINT ["sh", "/home/entrypoint.sh"]
