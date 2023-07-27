FROM powerman/dockerize:0.19.0 as dockerize
FROM gradle:jdk17-alpine
ARG USER_ID=
ARG GROUP_ID=
WORKDIR /app/
COPY ./testcontainers-java /app/
ENV DOCKER_HOST=tcp://dind:2375
ENV USER_ID=${USER_ID}
ENV GROUP_ID=${GROUP_ID}
COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin/
# Uncomment these lines if you have nexus
# WORKDIR /home/gradle/.gradle
# COPY init.gradle ./
# WORKDIR /home/gradle/.m2
# COPY settings.xml ./
WORKDIR /app/examples/redis-backed-cache-testng
RUN mkdir -p /app/report/java
CMD dockerize -wait $DOCKER_HOST -timeout 20s gradle test -Dorg.gradle.project.buildDir=/app/examples/redis-backed-cache-testng/build  && chown -R $USER_ID:$GROUP_ID /app/report




