## Dockerfile

FROM node:alpine
RUN mkdir -p /opt/app
WORKDIR /opt/app
RUN chown node:node .
# Install only dependencies
COPY --chown=node:node package.json yarn.lock prisma /opt/app/
# force yarn global cache to live in node_modules or will duplicate files
RUN yarn --global-folder ./node_modules/ --cache-folder ./node_modules/

# Install the rest of the code
COPY --chown=node:node . /opt/app
RUN chown -R app /opt/app
USER app
EXPOSE 3000 5555
CMD ["yarn", "dev"]
