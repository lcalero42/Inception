FROM debian:bookworm-slim

RUN apt update -y && apt install vsftpd -y

COPY ./tools/entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 21

CMD ["/entrypoint.sh"]