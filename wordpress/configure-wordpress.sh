#!/bin/bash

# Configure $wp_local_package global var

if ! grep '$wp_local_package' /var/www/html/wp-includes/version.php > /dev/null; then
  echo '' >> /var/www/html/wp-includes/version.php
  echo '$wp_local_package' = "'ru_RU';" >> /var/www/html/wp-includes/version.php
fi

rm -f /var/www/html/license.txt
rm -f /var/www/html/readme.html
rm -rf /var/www/html/wp-content/themes/twentynineteen
rm -rf /var/www/html/wp-content/themes/twentyseventeen
rm -rf /var/www/html/wp-content/themes/twentytwenty
