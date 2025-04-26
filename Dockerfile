FROM node:23 AS build

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM node:23.11.0-alpine3.21

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD ["npm", "start:prod"]