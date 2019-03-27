FROM alpine
RUN apk add openssh; mkdir /home/root; mkdir /home/root/.ssh
COPY launch.sh launch.sh
COPY tunnel-key tunnel-key
COPY tunnel-key.pub tunnel-key.pub
COPY known_hosts /root/.ssh/known_hosts
CMD /bin/sh launch.sh
