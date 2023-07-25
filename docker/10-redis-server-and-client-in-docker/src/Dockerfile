FROM redis:latest
ARG USER_ID=1000
ARG GROUP_ID=1000
ENV USER_ID=${USER_ID}
ENV GROUP_ID=${GROUP_ID}
RUN addgroup --gid $GROUP_ID anna
RUN adduser --uid $USER_ID -g $GROUP_ID -G anna -D anna
USER $USER_ID
