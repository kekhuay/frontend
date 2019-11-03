FROM node:alpine AS builder

WORKDIR /app
COPY ./package.json ./
COPY ./yarn.lock ./

RUN yarn install

COPY ./ ./

RUN yarn build
RUN ./node_modules/.bin/next export

FROM nginx

COPY --from=builder /app/out /usr/share/nginx/html
