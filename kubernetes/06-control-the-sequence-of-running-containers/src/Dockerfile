FROM powerman/dockerize:0.19.0 as dockerize
FROM ubuntu:23.10
COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin/
