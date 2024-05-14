### build container
FROM node:18-alpine as build
ENV NODE_ENV production

WORKDIR /src

# install terser
RUN --mount=type=cache,target=/root/.npm \
	npm i -g terser

# mount source and minify .js files
RUN --mount=type=bind,source=.,target=/src \
	/src/build.sh /build


### app container
FROM nginx:alpine

# copy built site to nginx container
COPY --from=build /build /usr/share/nginx/html
