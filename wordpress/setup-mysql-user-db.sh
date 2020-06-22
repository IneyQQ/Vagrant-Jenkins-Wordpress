#!/bin/bash
set -e
export MYSQL_PWD=$(sed -n 's/.*temporary password.*root@localhost: \(.*\)/\1/p' /var/log/mysqld.log)

mysql_select_output=$(mysql -uroot --connect-expired-password -e 'SELECT 1' 2>&1 || true)
if [[ `echo $mysql_select_output | grep 'You must reset your password'` != '' ]]; then
  mysql_is_password_expired=true
  echo 'Reset MySQL root password'
  mysql -uroot --connect-expired-password <<-EOF
	ALTER USER root@localhost identified by '$MYSQL_ROOT_PASSWORD';
	EOF
else
  mysql_is_password_expired=false
fi

export MYSQL_PWD=$MYSQL_ROOT_PASSWORD
mysql -uroot <<EOF
CREATE USER IF NOT EXISTS '$MYSQL_USERNAME'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DBNAME;
GRANT ALL PRIVILEGES ON $MYSQL_DBNAME.* to '$MYSQL_USERNAME'@'localhost';
EOF
