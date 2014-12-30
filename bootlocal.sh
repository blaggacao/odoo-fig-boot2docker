#!/bin/sh

# Use fig through a dedicated container
echo 'alias fig='"'"'docker run --rm -it \
                 -v $(pwd):/app \
                 -v /var/run/docker.sock:/var/run/docker.sock \
                 -e FIG_PROJECT_NAME=$(basename $(pwd)) \
                 dduportal/fig'"'" \
     >> /home/docker/.ashrc

# Softlink a persistend directory into home directory for convenience
ln -s /var/lib/docker/odoo /home/docker

# Kill all running containers.
echo 'alias dockerkillall='"'"'docker kill $(docker ps -q)'"'" \
     >> /home/docker/.ashrc

# Delete all stopped containers.
echo 'alias dockercleanc='"'"'printf "\n>>> Deleting stopped containers\n\n" && \
                         docker rm $(docker ps -a -q -f status=exited)'"'" \
     >> /home/docker/.ashrc

# Delete all untagged images.
echo 'alias dockercleani='"'"'printf "\n>>> Deleting untagged images\n\n" && \
                         docker rmi $(docker images -q -f dangling=true)'"'" \
     >> /home/docker/.ashrc

# Delete all stopped containers and untagged images.
echo 'alias dockerclean='"'"'dockercleanc || true && dockercleani'"'" \
     >> /home/docker/.ashrc

#Initialize Odoo Consistency volumes
echo 'alias odooinit='"'"'cd ~/odoo && fig \
-f init_persistent_volumes.yml \
-p odooinit up -d || true && cd -'"'" \
     >> /home/docker/.ashrc

#Start Odoo Services as defined in fig
echo 'alias odoostart='"'"'cd ~/odoo && \
fig -f fig.yml -p odoo up -d  && \
fig -f init_persistent_volumes.yml \
-p odooinit rm --force&& cd -'"'" \
     >> /home/docker/.ashrc

# put other system startup commands here

mkdir ~/hostfiles
# sudo mount -t cifs //[YOURHOSTPC]/[yoursharedfolder] ~/hostfiles -o user=Guest,nounix,sec=ntlmssp,noperm,rw