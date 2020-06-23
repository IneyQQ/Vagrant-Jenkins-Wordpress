#!/bin/bash
set -e

if [[ ! -f /var/www/html/wp-content/advanced-cache.php ]]; then
  cp /var/www/html/wp-content/plugins/w3-total-cache/wp-content/advanced-cache.php /var/www/html/wp-content/advanced-cache.php
  mkdir -p /var/www/html/wp-content/cache
  chmod 777 /var/www/html/wp-content/cache
  mkdir -p /var/www/html/wp-content/w3tc-config
  chmod 777 /var/www/html/wp-content/w3tc-config

  sed -i "\|^define( 'WP_DEBUG'|i define('WP_CACHE', true); // Added by W3 Total Cache" /var/www/html/wp-config.php
  cat /home/vagrant/wordpress/w3tc.htaccess > /var/www/html/.htaccess.tmp
  if [[ -f /var/www/html/.htaccess ]]; then
    cat /var/www/html/.htaccess >> /var/www/html/.htaccess.tmp
  fi
  cat /var/www/html/.htaccess.tmp > /var/www/html/.htaccess
  rm -f /var/www/html/.htaccess.tmp
fi
