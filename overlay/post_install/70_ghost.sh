#!/bin/sh

GHOST_PATH=/usr/local/share/ghost

# Install node packages
npm -g install ghost-cli

# Use ghost cli to install source
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

# create config file
ghost install --db mysql --no-prompt --no-stack --no-setup \
  --dbhost=localhost --dbuser=${USER} --dbpass=${PASS} --dbname=${DB} 
ghost config --ip 0.0.0.0 --port 2368 --no-prompt --db mysql \
  --dbhost=localhost --dbuser=${USER} --dbpass=${PASS} --dbname=${DB} \
  --url https://${HOST}

# Configure
sysrc ghost_enable=yes

# Start service
service ghost start

# Cleanup
npm cache clean --force