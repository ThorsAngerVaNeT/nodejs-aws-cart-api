FROM node:16-alpine
WORKDIR /usr/app
COPY package*.json ./
RUN npm install && npm cache clean --force
COPY . .
RUN npm run build
EXPOSE 4000
CMD [ "node", "dist/main.js" ]