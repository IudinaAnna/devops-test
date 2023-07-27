FROM powerman/dockerize:0.19.0 as dockerize
FROM python:3.9-slim
ARG USER_ID=1000
ARG GROUP_ID=1000
WORKDIR /app/
ENV USER_ID=${USER_ID}
ENV GROUP_ID=${GROUP_ID}
ENV DOCKER_HOST=tcp://dind:2375
COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin/
COPY ./testcontainers-python ./testcontainers-python/
RUN pip install --upgrade pip && apt-get update && apt-get install -y freetds-dev && rm -rf /var/lib/apt/lists/*
WORKDIR /app/testcontainers-python/redis
RUN pip install pytest-html testcontainers redis --no-cache-dir
RUN mkdir -p /app/report/python
CMD dockerize -wait $DOCKER_HOST -timeout 20s pytest -s --html=/app/report/python/report.html && chown -R $USER_ID:$GROUP_ID /app/report
