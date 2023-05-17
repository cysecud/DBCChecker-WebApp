FROM node:20.1-alpine

WORKDIR /app

ADD myapp/build/ .
COPY ./package.json .

EXPOSE 3000
CMD node index.js
