odoo-fig-boot2docker
====================

Easy and fast setup of consistent odoo instances

Environment
====================
- boot2docker official image running in a dedicated VM
- `sudo mount -t cifs` in `bootlocal.sh` is meant for windows hosts, however nfs should be available for linux, feel free to pullrequest the respective commented-out linux command

Usage
=====
In your boot2docker copy this line and enter. And then wait some seconds for you b2d to reboot.

```
git clone https://github.com/blaggacao/odoo-fig-boot2docker.git && \
chmod 777 ./odoo-fig-boot2docker/* && \
cd ./odoo-fig-boot2docker && \
./setup.sh
```

Reboot is done, you're in the console of your boot2docker again, you can:

`odooinit` to initialize persistent data volumes (first time lasts until relevant images are downloaded - ca 4GB)
`odoostart` to spin up odoo services, open V8 on port 8069 and V9 on port 9069 of your docker-ip

`alias` for other commands related to cleaning up your docker environment.

If you want to have a shared folder via samba, follow this guide:
http://www.howtogeek.com/176471/how-to-share-files-between-windows-and-linux/
**AND**
Uncomment and adapt the last line of the bootlocal.sh and put in your PC and Shared folder