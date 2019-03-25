FROM alpine

RUN apk add git; apk add openssh; mkdir repo; git config --global user.email "kngnm@bsc.coop"; git config --global user.name "kngnm"
COPY backup.sh backup.sh
COPY backup-key backup-key
COPY backup-key.pub backup-key.pub
COPY known_hosts /root/.ssh/known_hosts
CMD sh backup.sh
