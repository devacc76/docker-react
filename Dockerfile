FROM node:14-alpine as builder

ENV http_proxy="http://free.npp:8080/"
ENV https_proxy="http://free.npp:8080/"

WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
