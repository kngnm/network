Hosting Guide
=============

IP Address
----------

```
Public Static IP Address: 64.62.133.46
Fully Qualified Domain Name (FQDN): kingmanhall.org
SSL Certificate Authority: Let's Encrypt
```

Notes:
- The ip address is from Cloyne's pool of static ips from hurricane electric.  Contact the Cloyne network manager for more specific information.  
- The domain name is owned by Ping (zestyping@gmail.com), a former kingman network manager.  Contact him if you need to move it to a new ip address.
- The SSL certificate is provided by [Let's Encrypt CA](https://letsencrypt.org/getting-started/).  To set up the certificate on a new host, download [Certbot](https://certbot.eff.org/lets-encrypt/debianother-nginx) and follow their instructions.  To manually renew the certificate on the current setup, ssh into kingmanhall.org and run `sudo ./certbot-auto renew`.  Ideally, this should be preformed by the following cron job on the host machine:

```
0 12 * * * sudo /home/kngnm/certbot-auto renew
```

Layout Diagram
--------------

![Layout Diagram](https://raw.githubusercontent.com/kngnm/network/master/documentation/diagrams/hosting.png)

Life Cycle of a Kingman Web Page Request
----------------------------------------

1. Alice opens up a web browser and types kingmanhall.org/<service> into the search bar of a web browser.  
2. The web browser makes a DNS query to determine the IP address of kingmanhall.org.  It gets a response from a DNS server of 64.62.133.46.
3. The browser sends an HTTP GET Request to kingmanhall.org.
4. This packet reaches `clo-router`.  It routes the packet to `kingman-reverse-proxy` because it is on Cloyne's network and has a static ip address of 64.62.133.46.
5. `kingman-reverse-proxy` receives the GET request.  It analyzes the requested URL and determines what <service> refers to.  It sends a GET request for the same page to the corresponding server inside kingman.
6. The server receives the request, processes it, and sends the HTML code for the requested page back to `kingman-reverse-proxy`
7. `kingman-reverse-proxy` forwards the response to the web browser.
8. The response is routed back to Alice's computer via `clo-router`.  Alice's web browser receives the HTML code, renders it, and displays it to Alice.

Configuring a New Service to be Hosted
--------------------------------------

1. Setup the web server on one of Kingman's servers.  See the [Docker Guide](https://raw.githubusercontent.com/kngnm/network/master/documentation/docker.md) for more information on how to integrate it into the current stack.
2. Ensure that you can access the website locally.  That is, try typing the local ip address of the server into a browser and see if the page loads.
3. Decide on a URL for the service.  It should be of the form kingmanhall.org/[service name here].  Try and make it as short and memorable as possible.
4. Configure the reverse proxy.  First, login to `kingman-reverse-proxy` via ssh.  Then edit /etc/nginx/sites-enabled/default (this can be done via terminal with the command `sudo nano /etc/nginx/sites-enabled/default`).  The content of the file will look something like (but not exactly like) this:
```
server {
  listen 443 ssl;
  ssl_certificate /etc/letsencrypt/live/kingmanhall.org/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/kingmanhall.org/privkey.pem;
  location / {
    proxy_pass http://localhost:3000;
  }
}
```  
Add another location block to the file in the following way.  Note that `port` should be a number not already present in a `proxy_pass` URL.
```
server {
  listen 443 ssl;
  ssl_certificate /etc/letsencrypt/live/kingmanhall.org/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/kingmanhall.org/privkey.pem;
  location / {
    proxy_pass http://localhost:3000;
  }
  location /<service name here> {
    proxy_pass http://localhost:<port>;
  }
}
```
5. Create a temporary ssh tunnel from the web server to `kingman-reverse-proxy` with the following command, where service port is the port the web server is bound on the local machine: `ssh -R <port>:localhost:<service port> kngnm@kingmanhall.org`.  At this point, you should be able to access your web service at kingmanhall.org/[service name here].
6. Add a permanent ssh tunnel container to the docker stack for the host machine.  A docker-compose yaml snippet that will accomplish this is included below.  See the [Docker Guide](https://raw.githubusercontent.com/kngnm/network/master/documentation/docker.md) for specifics of the docker stack.

```
<service name here>-tunnel:
  image: kngnm/ssh-tunnel
  network_mode: host
  environment:
    - "LOCAL_PORT: <service port>"
    - "REMOTE_PORT: <port>"
    - "REMOTE_HOST: kingmanhall.org"
    - "USERNAME: kngnm"
  volumes:
    - "~/.ssh:/home/root/.ssh"
```

Firewall Configuration
----------------------

There will be some services on `kingman-reverse-proxy` that ideally should not be accessible to the outside world (ssh for example).  To deny access to these services to people outside of Kingman Hall, configure the local firewall on `kingman-reverse-proxy` to drop packets that do not originate from Cloyne's router.  This can be done using [iptables](https://www.booleanworld.com/depth-guide-iptables-linux-firewall/) with the following commands (replace <port> with the desired port number):
```
sudo apt-get install iptables-persistent
sudo iptables -A INPUT -p tcp -s 64.62.133.42 --dport <port> -j ACCEPT
sudo iptables -A INPUT -p tcp --dport <port> -j DROP
iptables-save > /etc/iptables/rules.v4
```
Then log into a school computer and attempt to ssh into `kingmanhall.org`.  If the firewall is configured correctly, you will not receive a response.
