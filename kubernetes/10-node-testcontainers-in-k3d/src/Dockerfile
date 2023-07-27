FROM powerman/dockerize:0.19.0 as dockerize
FROM node:20.3.1-slim
ARG USER_ID=1000
ARG GROUP_ID=1000
WORKDIR /app/
ENV DOCKER_HOST=tcp://dind:2375
COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin/
COPY ./testcontainers-node ./jest.config.js ./
ENV USER_ID=${USER_ID}
ENV GROUP_ID=${GROUP_ID}
RUN npm install --save-dev jest-html-reporter
#Use it if you have nexus
#COPY ./.npmrc $HOME/
WORKDIR /app/src/modules/postgresql
RUN npm install
RUN mkdir -p /app/report/node
CMD dockerize -wait $DOCKER_HOST -timeout 20s npm test postgresql-container.test.ts && chown -R $USER_ID:$GROUP_ID /app/report
