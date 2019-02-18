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
