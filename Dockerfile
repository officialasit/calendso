## Dockerfile

FROM node:14.16.1-alpine3.10
RUN mkdir -p /opt/app
WORKDIR /opt/app

# Change to node user
RUN chown node:node .
USER node

# Install only dependencies
COPY --chown=node:node package.json yarn.lock prisma /opt/app/

# force yarn global cache to live in node_modules or will duplicate files
RUN yarn --global-folder ./node_modules/ --cache-folder ./node_modules/

# Install the rest of the code
COPY --chown=node:node . /opt/app

EXPOSE 3000 5555
CMD ["yarn", "dev"]
