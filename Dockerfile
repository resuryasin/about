FROM node:20.5.0-bullseye-slim as builder
#FROM node:20.5.0-bullseye-slim
ENV NODE_ENV production
RUN mkdir -p /usr/src/profile
WORKDIR /usr/src/profile
COPY package.json package.json
RUN npm install -g npm@10.1.0
COPY . .
RUN npm run build

FROM node:20.5.0-bullseye-slim as production
ENV NODE_ENV production
COPY --from=builder /usr/src/profile /usr/src/profile
WORKDIR /usr/src/profile
EXPOSE 3000
CMD ["npm", "run", "start"]
