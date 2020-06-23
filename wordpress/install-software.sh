#!/bin/bash

echo "--- INSTALL SOFTWARE START ---"

echo "Install unzip, wget"
yum install -y unzip wget > /dev/null

echo "Install MySQL repo"
yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm > /dev/null
echo "Install MySQL server"
yum install -y mysql-server > /dev/null
echo "Start mysql server"
systemctl start mysqld
systemctl enable mysqld

echo "Install PHP repo"
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm > /dev/null
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm > /dev/null
yum install -y yum-utils > /dev/null
yum-config-manager --enable remi-php56 > /dev/null
echo "Install PHP 5.6"
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo > /dev/null

echo "Install apache"
yum -y install httpd > /dev/null
systemctl start httpd
systemctl enable httpd

echo "Install SEManage"
yum install -y policycoreutils-python-2.5-34.el7.x86_64 > /dev/null

if [[ ! -f wordpress-5.4.1.zip ]]; then
  echo "Download wordpress"
  wget -q https://wordpress.org/wordpress-5.4.1.zip
  echo "Unzip wordpress"
  unzip wordpress-5.4.1.zip > /dev/null
  mv wordpress/* /var/www/html
  rmdir wordpress
  restorecon -Rv /var/www/html
fi

echo "--- INSTALL SOFTWARE END ---"
