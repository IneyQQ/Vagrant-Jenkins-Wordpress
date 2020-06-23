#!/bin/bash
cd /var/www/html
if [[ ! -f wp-config.php ]]; then
  echo "Set up WordPress MySQL connection"
  tr -d '\015' < wp-config-sample.php > wp-config.php
  sed -i "s/database_name_here/$MYSQL_DBNAME/" wp-config.php
  sed -i "s/username_here/$MYSQL_USERNAME/" wp-config.php
  sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config.php
fi

