FROM node:12.16.0

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN yarn install

COPY . .

CMD ["node", "./src/client.js"]