# Rocket.chat Server Image
# Instructions from: https://rocket.chat/docs/installation/manual-installation/ubuntu/
# Build: docker build -t rocketchat .
# Run: docker run -p 3000:[external port] -it rocketchat

FROM ubuntu:18.04

ENV PORT 3000
ENV HOST your-host-name.com-as-accessed-from-internet
ENV ROOT_URL http://$HOST:$PORT/

# Set mirror to US Server (helps with build speed)
COPY sources.list /etc/apt/sources.list

RUN apt update
RUN apt install -y tzdata

# Dependency for apt-key
RUN apt install -y gnupg

# Add Mongo DB apt repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list

# Reinstall Certificates (https://askubuntu.com/questions/420860/problem-with-certificates)
RUN apt-get install -y --reinstall ca-certificates

# Configure Node JS
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Install Dependencies
RUN apt-get install -y build-essential
RUN apt-get install -y mongodb-org
RUN apt-get install -y nodejs
RUN apt-get install -y graphicsmagick
RUN npm install -g inherits n; n 8.11.3

# Download RocketChat
RUN curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz
RUN tar -xzf /tmp/rocket.chat.tgz -C /tmp

# Install RocketChat
RUN bash -c 'cd /tmp/bundle/programs/server; npm install'
RUN mv /tmp/bundle /opt/Rocket.Chat

# Configure RocketChat
RUN useradd -M rocketchat; usermod -L rocketchat
RUN chown -R rocketchat:rocketchat /opt/Rocket.Chat
RUN echo -e "[Unit]\nDescription=The Rocket.Chat server\nAfter=network.target remote-fs.target nss-lookup.target nginx.target mongod.target\n[Service]\nExecStart=/usr/local/bin/node /opt/Rocket.Chat/main.js\nStandardOutput=syslog\nStandardError=syslog\nSyslogIdentifier=rocketchat\nUser=rocketchat\nEnvironment=MONGO_URL=mongodb://localhost:27017/rocketchat ROOT_URL=http://your-host-name.com-as-accessed-from-internet:3000/ PORT=3000\n[Install]\nWantedBy=multi-user.target" | tee /lib/systemd/system/rocketchat.service

# Create Start Script (because we can't use systemd in docker) to be run on launch
RUN echo "#!/bin/bash\n\nmongod --config /etc/mongod.conf &\nsleep 2\n\nexport MONGO_URL=mongodb://localhost:27017/rocketchat\nexport ROOT_URL=$ROOT_URL\nexport PORT=$PORT\n/usr/local/bin/node /opt/Rocket.Chat/main.js" > /bin/launch
RUN chmod a+x /bin/launch
ENTRYPOINT launch

# Open Port
EXPOSE $PORT
