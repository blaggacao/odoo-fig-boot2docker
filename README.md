odoo-fig-boot2docker
====================

Easy and fast setup of consistent odoo instances

Introduction
============
What is it exactly?
--------------
This easily spins up two odoo instances for playing (V8 & latest) in a containerized (docker) way within a boot2docker instance which you might use if you are trying to use docker on windows or mac for example. On the other hand it is a proof of concept of getting Odoo with the technologies mentioned hereafter.

Why would I use it?
------------------
If you got boot2docker running which is easy with it's CLI, this get you the instances running with two simple commands.
You might use host folder share to pull your source folders into the boot2docker and adapt the fig yaml-files to mount those shared folders using cifs (windows) or ntf (unix) into the Odoo dockers. Look at the files, it might be even self-explanatory.
This way you can get a nice dev-server which could run your code via a `docker exec CONTAINER ODOOSTARCOMMAND` with a specially provided config file or from the host via ssh execution of this command.

What technology does it use?
-----------------
- Docker : LXC containerization, same as Virtual Machines, but less overhead ("lean")
- Boot2Docker : LXC is only available on up-to-date linux kernels, Windows NOT, boot2docker is an special purpose very Tiny Core Linux ISO, you woudl mount in a virtual machine, for ease of use, use the boot2docker-cli to get out of the way the hassle of cofiguring your VM-Environment (does not support Hyper-V yet)
- Fig : Fig is docker orchestration via yaml fiels developped by the docker team (similar to what ansible or google kybernates does)
- CIFS / NFS : can be used for folder sharing, this is usfeul to get your sourcode onto the dockers. (see usage)

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