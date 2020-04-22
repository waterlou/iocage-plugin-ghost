#!/bin/sh

service nginx stop
service ghost stop
service mysql-server stop


service mysql-server start
service ghost start
service nginx start
