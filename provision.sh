#! /bin/sh

# Update package list.
/usr/bin/apt-get -y update
# Install jupyterhub components.
/usr/bin/apt-get -y install python3-pip
/usr/bin/apt-get -y install -y npm nodejs-legacy
/usr/bin/npm install -g configurable-http-proxy
/usr/bin/python3 -m pip install jupyterhub
# Install the python3 Jupyter notebook.
/usr/bin/python3 -m pip install notebook
/usr/bin/python3 -m pip install matplotlib
/usr/bin/python3 -m pip install pandas
# Install Jupyterhub Remote Authenticator
/usr/bin/python3 -m pip install jhub_remote_user_authenticator
# Install Apache2 httpd, required modules, and configure the proxy.
/usr/bin/apt-get -y install apache2
/usr/sbin/a2enmod proxy_wstunnel
/usr/sbin/a2enmod request
/usr/sbin/a2enmod proxy_http
/usr/sbin/a2enmod headers
cp /vagrant/etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-available/fqdn.conf
chgrp www-data /etc/apache2/conf-available/fqdn.conf
/usr/sbin/a2enconf fqdn
cp /vagrant/etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
chgrp www-data /etc/apache2/sites-available/000-default.conf
# Copy jupyterhub config and basic auth password database to target folder.
mkdir -p /srv/jupyterhub
cp /vagrant/srv/jupyterhub/jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py
cp /vagrant/srv/jupyterhub/basic-auth_passwd /srv/jupyterhub/basic-auth_passwd
chgrp www-data /srv/jupyterhub/basic-auth_passwd
chmod u=rw,g=r,o= /srv/jupyterhub/basic-auth_passwd
# Copy jupyterhub service file.
cp /vagrant/etc/systemd/system/jupyterhub.service /etc/systemd/system/
# Start services.
/bin/systemctl start jupyterhub
/bin/systemctl start apache2

