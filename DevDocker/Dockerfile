FROM python:2.7.9-wheezy
MAINTAINER David Arnold (DevCO) <dar@devco.co>

WORKDIR /tmp

ADD requirements.txt /tmp/requirements.txt
ADD pycharm-debug-py3k.egg /tmp/pycharm-debug.egg

RUN \
# Install python dependencies
  pip install \
    --upgrade \
    --use-wheel \
    --no-index \
    --pre \
    # Use wheels from xcgd people in order to get always the right version in wheel.
    --find-links=https://wheelhouse.openerp-experts.net/trusty/odoo/ \
    # make .pyc out of .py - don't know if it's done by the wheels already
    --compile \
    --requirement requirements.txt

RUN \
# Some dependencies to wkhtmltopdf
    apt-get update \
    && apt-get --fix-broken install \
    && apt-get --quiet --assume-yes install xfonts-base xfonts-75dpi \
# Install newest version of wkhtmltopdf
    && wget http://sourceforge.net/projects/wkhtmltopdf/files/0.12.2/wkhtmltox-0.12.2_linux-wheezy-amd64.deb \
    && dpkg -i /tmp/wkhtmltox-0.12.2_linux-wheezy-amd64.deb

# We set the odoo user and group fixed for compatibility with connectors and hosts - in case we need it.
    && addgroup --gid=1000 odoo \
    && adduser --system --uid=1000 --gid=1000 --home /home/odoo --shell /bin/bash odoo

RUN \
# pycharm debug server is installed from egg
    easy_install /tmp/pycharm-debug.egg

RUN \
# cifs (samba) is installed in order to mount shared windows folders.
    apt-get --quiet --assume-yes install cifs-utils \
    && apt-get --quiet --assume-yes autoremove \
# /tmp is cleaned.
    && rm -r /tmp/*

# Expose Odoo's Standard Port
EXPOSE 8069
# Expose Odoo's Extra Port (What is it actually for?)
EXPOSE 8072

ENTRYPOINT ["python2"]
