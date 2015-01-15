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
    # make .pyc out of .py
    --compile \
    --requirement requirements.txt

RUN \
# Install newest version of wkhtmltopdf
     wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb \
  && dpkg -i /tmp/wkhtmltox-0.12.1_linux-trusty-amd64.deb

# We set the odoo user and group fixed for compatibility with connectors and hosts - in case we need it.
  && addgroup --gid=1000 odoo \
  && adduser --system --uid=1000 --gid=1000 --home /home/odoo --shell /bin/bash odoo

RUN \
# We install the pycharm egg for remote debugging (Debug-Server)
     easy_install /tmp/pycharm-debug.egg

RUN \
# We install cifs-utils in order to access a shared folder on windows (samba)
     apt-get update && apt-get install cifs-utils && apt-get autoremove

# We cleanup the tmp-dir
  && rm -r /tmp/*

# Expose Odoo's Standard Port
EXPOSE 8069
# Expose Odoo's Extra Port (What is it actually for?)
EXPOSE 8072

ENTRYPOINT ["python2"]
