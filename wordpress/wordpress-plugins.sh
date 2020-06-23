#!/bin/bash
set -e
echo "--- INSTALL WORDPRESS PLUGINS START ---"

cd /var/www/html/wp-content/plugins
rm -rf akismet
rm -f hello.php

while read plugin_record; do
  plugin_name=$(echo $plugin_record | cut -f1 -d" ")
  if [[ "$(echo $plugin_record)" == 2 ]]; then
    plugin_version=$(echo $plugin_record | cut -f2 -d" ")
    plugin_download_name=$plugin_name.$plugin_version
  else
    plugin_download_name=$plugin_name
  fi
  if [[ ! -d $plugin_name ]] && [[ ! -f $plugin_name.php ]]; then
    echo Download $plugin_download_name
    wget -q https://downloads.wordpress.org/plugin/$plugin_download_name.zip
    unzip $plugin_download_name.zip > /dev/null
    rm -f $plugin_download_name.zip
  fi
done < /home/vagrant/wordpress/wordpress-plugins.list

restorecon -Rv /var/www/html/wp-content/plugins

echo "--- INSTALL WORDPRESS PLUGINS END ---"
