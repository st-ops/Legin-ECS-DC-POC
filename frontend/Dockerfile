FROM node:20-alpine

WORKDIR ./frontend

COPY . .

RUN npm i 

ENV NODE_OPTIONS --openssl-legacy-provider

EXPOSE 3000

CMD [ "npm", "run", "start" ]