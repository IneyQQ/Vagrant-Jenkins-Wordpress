#!/bin/bash

# Install WordPress if not installed
# Mark Jenkins restart if Jenkins not installed
#bash install-software.sh
bash setup-mysql-user-db.sh
bash wordpress-mysql-connection.sh
#bash wordpress-plugins.sh
bash plugin-w3-total-cache-setup.sh
bash configure-wordpress.sh
