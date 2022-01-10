FROM node:16.13.1

RUN mkdir -p /app

WORKDIR /app

COPY . .

EXPOSE 3000

CMD [ "sh", "/app/scripts/entrypoint.docker.sh" ]
