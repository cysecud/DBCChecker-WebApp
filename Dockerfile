FROM node:20.1-alpine

WORKDIR /app

ADD dbcchecker/build/ .
COPY ./package.json .

EXPOSE 3000
CMD node index.js
