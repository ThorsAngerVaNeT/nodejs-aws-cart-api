FROM mhart/alpine-node:16 as builder
WORKDIR /app
COPY ["package.json", "package-lock.json", "./"]
RUN npm ci && npm cache clean --force
COPY . .
RUN npm run build && npm prune --production


FROM alpine
RUN apk add --update nodejs npm
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app .
EXPOSE 4000
CMD [ "node", "dist/main.js" ]