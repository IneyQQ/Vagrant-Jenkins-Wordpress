#!/bin/bash

# Install WordPress if not installed
# Mark Jenkins restart if Jenkins not installed
bash install-software.sh
bash setup-mysql-user-db.sh
exit 0

wordpress_installed_check_output=$(dpkg -l | egrep '^ii *wordpress *')
if [ "$wordpress_installed_check_output" != "" ]; then
  wordpress_first_install=false
else
  wordpress_first_install=true
  bash install-software.sh
  require_wordpress_restart=true
fi

