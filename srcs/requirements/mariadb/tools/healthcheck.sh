#!/bin/sh
mysqladmin ping -h localhost -u root -p$(cat /run/secrets/mysql_root_password)
