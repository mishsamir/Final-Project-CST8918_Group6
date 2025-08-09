# base node image
FROM node:lts-alpine AS base

# update the openssl package to apply a security patch @see CVE-2023-6129⁠
RUN apk -U add --update-cache openssl

# set for base and all layer that inherit from it
ENV NODE_ENV=production
ENV NODE_ENV=production

# Install all node_modules, including dev dependencies
FROM base AS deps

WORKDIR /usr/src/app

ADD package.json ./
RUN npm install --include=dev

# Setup production node_modules
FROM base AS production-deps

WORKDIR /usr/src/app

COPY --from=deps /usr/src/app/node_modules /usr/src/app/node_modules
ADD package.json ./
RUN npm prune --omit=dev

# Build the app
FROM base AS build

WORKDIR /usr/src/app

COPY --from=deps /usr/src/app/node_modules /usr/src/app/node_modules

# Copy all source files needed for build
COPY package.json ./
COPY tsconfig.json ./
COPY remix.config.js ./
COPY remix.env.d.ts ./
COPY app ./app
COPY public ./public

# Build with production NODE_ENV for correct JSX transforms
ENV NODE_ENV=production

# Run build with error handling
RUN npm run build || (echo "Build failed. Checking environment..." && ls -la && echo "Node version:" && node --version && echo "NPM version:" && npm --version && exit 1)

# Finally, build the production image with minimal footprint
FROM base

WORKDIR /usr/src/app

# Reset NODE_ENV to production for runtime
ENV NODE_ENV=production

COPY --from=production-deps /usr/src/app/node_modules /usr/src/app/node_modules

COPY --from=build /usr/src/app/build /usr/src/app/build
COPY --from=build /usr/src/app/public /usr/src/app/public
COPY --from=build /usr/src/app/package.json /usr/src/app/package.json

CMD [ "/bin/sh", "-c", "./node_modules/.bin/remix-serve ./build/index.js" ]
