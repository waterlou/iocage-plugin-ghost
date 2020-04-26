#!/bin/sh

GHOST_PATH=/usr/local/share/ghost
LOG_PATH=/var/log/ghost

# Install node packages
npm -g install ghost-cli

mkdir -p ${LOG_PATH}
chown www:www ${LOG_PATH}

mkdir -p ${GHOST_PATH}
cd ${GHOST_PATH}

# symbolic mysqld to pass checking
ln -s /usr/local/bin/mysqld_multi /usr/local/bin/mysqld

# read db settings
CFG=/root/plugin_config

DB=`sysrc -f ${CFG} -n mysql_db`
USER=`sysrc -f ${CFG} -n mysql_user`
PASS=`sysrc -f ${CFG} -n mysql_pass`

HOST=`sysrc -n hostname`

# install and create config file
ghost install --db mysql --no-prompt --no-stack --no-setup
ghost config --ip 0.0.0.0 --port 2368 --no-prompt --db mysql \
  --dbhost=localhost --dbuser=${USER} --dbpass=${PASS} --dbname=${DB} \
  --url https://${HOST}.local
ghost config set database.connection.socketPath /tmp/mysql.sock
ghost config set process local
ghost config set logging.path /var/log/ghost/

# change owner
chown -R www:www ${GHOST_PATH}

# Configure
# sysrc ghost_enable=yes
sysrc ghost_url=http://localhost

# Start service
service ghost start
