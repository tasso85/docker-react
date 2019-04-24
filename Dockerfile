FROM node:alpine AS builder
WORKDIR /usr/app
COPY package.json .
RUN npm config set registry http://registry.npmjs.org/ && npm set progress=false && npm install --verbose
COPY . .
RUN npm run build

FROM nginx:alpine
EXPOSE 80
COPY --from=builder /usr/app/build /usr/share/nginx/html