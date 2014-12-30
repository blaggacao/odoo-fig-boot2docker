#!/bin/sh

sudo -s
cp ./bootlocal.sh /var/lib/boot2docker/
cp -r ./odoo /var/lib/docker/
reboot