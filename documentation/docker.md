Docker Guide
============

The services deployed on the house servers are run in [docker](https://docs.docker.com/get-started/) containers, which are orchestrated using [docker-compose](https://docs.docker.com/compose/gettingstarted/).  

What is Docker?
-----------

`docker` is a program that is used to run applications inside lightweight, Linux virtual machines.  These virtual machines are know as docker images.  Docker images are self-contained and operating system independent, making it relatively easy to install them on any computer.  You can create a docker image for any application either by [writing and building a Dockerfile](https://docs.docker.com/get-started/) for the desired application or downloading a pre-built image for that application online from [Dockerhub](https://hub.docker.com/).  Once you have an image, you can deploy it using [docker-compose](https://docs.docker.com/compose/gettingstarted/).  `docker-compose` is a program that helps manage containerized services.  It automatically updates services to their latest version, backs up their data, and restarts them when they crash, among other things.  

Docker-Compose YML Files
------------------------

```
version: '2'
  services:

    mongodb:
      image: mongo
      ports:
        - "8081:27017"
      restart: always
      volumes:
        - /var/lib/mongodb:/data/db

    rocketchat:
      image: rocket.chat
      ports:
        - "3000:3000"
      depends_on:
        - "mongodb"
      environment:
        MONGO_URL: mongodb://172.17.0.1:8081
```
The `docker-compose.yml` file describes the services running on a machine and their configurations.  In  Each service has its own block nested inside the services block.  The block consists of the name of the service (e.g. mongodb) followed by indented configuration settings.  For example, the stack above contains a mongodb database server hosted on port 8081 that restarts on crash and shares /var/lib/mongodb with the host machine.  To add a new service to the stack, open up `docker-compose.yml` in a text editor and append a new block to the end of the file.  Here is a list of some of the most common configuration items (a more complete list can be found [here](https://docs.docker.com/compose/compose-file/)):
1. image - specifies the docker image that this service will run.  For example, mongo is a containerized image of mongodb downloaded from [Dockerhub](https://hub.docker.com/_/mongo).  Images can be downloaded from dockerhub by running `docker pull <image_name>` where <image_name> is the name of the image on dockerhub.
2. build - specifies the path of a Dockerfile used to build the image this service will run.
3. ports - configures which ports will be opened to the host machine.  The following list of ports is formatted "<external_port>:<internal_port>"  That is, the service hosts a web site on port <internal_port> and you would like it to be accessible from the host machine at port <external_port>
4. depends_on - specifies that another service, (A), specified in this docker-compose.yml file needs to be launched before this one (B), because B depends on A.
5. restart: always - this service will always be restarted when it crashes.
6. environment - specifies environment variables to declare in the environment of the containerized program
7. volumes - (<host_dir:local_dir>) tells docker to mount host_dir on the host machine to local_dir on the local machine.  As a result, the docker image will be able to read and write to files in that directory on the host machine.  This allows the docker service to persist data between restarts

When you are done specifying the stack, run `docker-compose up` in the same directory as your `docker-compose.yml` to apply the changes.  For more advanced usage of the `docker-compose` command, see the [Compose Command Line Reference](https://docs.docker.com/compose/reference/).

Docker Files
------------

If you can't find an image for the program you are looking for on Dockerhub, you may have to build it yourself.  Here's an example Dockerfile (for a CUPS print server) with annotations:

```
FROM ubuntu:18.04

RUN apt-get update; \
    apt-get install --no-install-recommends -y wget cups cups-pdf hplip smbclient avahi-daemon avahi-utils libnss-mdns; \
    wget --no-check-certificate https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.1-1.gz;\
    gunzip linux-brprinter-installer-2.2.1-1.gz; \
    mv linux-brprinter-installer-2.2.1-1 brprinter; \
    chmod u+x brprinter; \
    echo 'y\nY\nY\nN\nN' | bash brprinter HL2240; \
    echo 'y\nY\nY\nN\nN' | bash brprinter MFC9340

COPY cupsd.conf /etc/cups/
CMD /usr/sbin/cupsd -f
EXPOSE 631
```

1. FROM - this specifies the baseimage which this container is built upon.  Most of the time this is the operating system that the containerized service will run in.  For example, this Dockerfile uses [Ubuntu 18.04](https://hub.docker.com/_/ubuntu), a solid choice for most applications.  Another commonly used baseimage is [Alpine Linux](https://hub.docker.com/_/alpine), which takes up less disk space than ubuntu.
2. RUN - run bash script inside the container to set it up.  The example bash script installs CUPS and some printer drivers on the image.
3. COPY <host_file> <local_dest> - copies the file on the host machine at path <host_file> to path <local_dest> inside the docker image.
4. CMD - specifies the command to run in the docker image to initialize the containerized program.  The example command starts CUPS.
5. EXPOSE - allow a port to be redirected to the host machine (e.g. by specifying a port-configuration in the `docker-compose.yml` file).
