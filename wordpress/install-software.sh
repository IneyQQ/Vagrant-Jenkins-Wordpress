#!/bin/bash

echo "--- INSTALL SOFTWARE START ---"

echo "Install MySQL repo"
yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
echo "Install MySQL server"
yum install -y mysql-server
echo "Start mysql server"
systemctl start mysqld



echo "--- INSTALL SOFTWARE END ---"
