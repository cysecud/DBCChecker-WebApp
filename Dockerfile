FROM node:20.1-alpine AS build

WORKDIR /dbcchecker

COPY dbcchecker/package.json .
COPY dbcchecker/package-lock.json .

RUN npm install

COPY dbcchecker /dbcchecker

RUN npm run build

FROM node:20.1-alpine

WORKDIR /app

COPY --from=build /dbcchecker/build .
COPY --from=build /dbcchecker/package.json .

EXPOSE 3000
CMD ["node", "index.js"]
