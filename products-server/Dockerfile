FROM node:20-alpine

WORKDIR ./backend

COPY . .

RUN npm i

RUN apk add mysql-client

EXPOSE 4000

CMD [ "node", "index.js" ]