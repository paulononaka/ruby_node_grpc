FROM node:12.16.0

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

CMD ["node", "./src/client.js"]

EXPOSE 3000