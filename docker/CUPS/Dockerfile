FROM ubuntu:16.04

RUN apt update; apt install -y cups
RUN apt install -y curl
RUN apt install -y nano

COPY config /etc/cups

ENTRYPOINT service cups start && /bin/bash

EXPOSE 631
