FROM alpine
RUN apk add openssh; mkdir /home/root; mkdir /home/root/.ssh
COPY launch.sh launch.sh
ENTRYPOINT /bin/sh launch.sh
