#!/bin/bash

#import the variables from env into the init file
envsubst < /tmp/init.sql > /tmp/init_real.sql

# Ensure permissions are correct
chown mysql:mysql /tmp/init_real.sql
chmod 644 /tmp/init_real.sql

exec mysqld --init-file=/tmp/init_real.sql
