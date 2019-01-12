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

# Copy in install script and run it
COPY install /bin/install
RUN chmod u+x /bin/install; bash /bin/install

# Run launch script on startup
ENTRYPOINT launch

# Open Port
EXPOSE $PORT
