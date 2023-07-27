FROM redis:latest
ARG USER_ID=1000
ARG GROUP_ID=1000
ENV USER_ID=${USER_ID}
ENV GROUP_ID=${GROUP_ID}
RUN groupadd --gid $GROUP_ID md_aiudina
RUN useradd --uid $USER_ID -g $GROUP_ID -rm md_aiudina
USER $USER_ID