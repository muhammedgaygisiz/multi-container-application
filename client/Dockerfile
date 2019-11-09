# Build step
FROM node:alpine as builder

WORKDIR '/app'

COPY ./package.json ./

RUN npm install

COPY . .

RUN npm run build

# Package step: get only necessary files
# into final image
FROM nginx

EXPOSE 3000

COPY ./nginx/default.conf /etc/nginx/config.d/default.conf

COPY --from=builder /app/build /usr/share/nginx/html