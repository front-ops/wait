FROM node:20-bookworm-slim AS base

FROM base AS build
WORKDIR /app

# By copying only the package.json and package-lock.json here, we ensure that the following `-deps` steps are independent of the source code.
# Therefore, the `-deps` steps will be skipped if only the source code changes.
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

#FROM base AS runtime
#COPY --from=build /app/node_modules ./node_modules
#COPY --from=build /app/dist ./dist

#ENV HOST=0.0.0.0
#ENV PORT=4321
#EXPOSE 4321
#CMD node ./dist/server/entry.mjs

FROM nginx:alpine AS runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080

