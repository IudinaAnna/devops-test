FROM powerman/dockerize:0.19.0 as dockerize
FROM ubuntu:23.10
COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin/
RUN echo 'Hello World !!!' > test.txt
CMD dockerize --wait file:///test.txt -timeout 20s && cat test.txt
