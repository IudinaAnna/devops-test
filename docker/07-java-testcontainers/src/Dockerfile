FROM powerman/dockerize:0.19.0 as dockerize
FROM gradle:jdk17-alpine
ARG USER_ID=1000
ARG GROUP_ID=1000
WORKDIR /app/
COPY ./testcontainers-java /app
COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin/
ENV DOCKER_HOST=tcp://dind:2375
ENV USER_ID=${USER_ID}
ENV GROUP_ID=${GROUP_ID}
# Use these commands if you set up Nexus
# WORKDIR /home/gradle/.gradle
# COPY init.gradle ./
# WORKDIR /home/gradle/.m2
# COPY settings.xml ./
WORKDIR /app/examples/redis-backed-cache-testng
CMD dockerize -wait $DOCKER_HOST gradle test && chown -R ${USER_ID}:${GROUP_ID} /app/examples/redis-backed-cache-testng/build
