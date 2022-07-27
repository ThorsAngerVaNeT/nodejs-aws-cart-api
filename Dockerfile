FROM mhart/alpine-node:16 as builder
WORKDIR /app
COPY ["package.json", "package-lock.json", "./"]
RUN npm ci && npm cache clean --force
COPY . .
RUN ["npm", "run", "build"]
RUN ["npm", "prune", "--production"]


FROM mhart/alpine-node:slim-16
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app .
EXPOSE 4000
CMD [ "node", "dist/main.js" ]