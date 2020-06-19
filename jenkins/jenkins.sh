#!/bin/bash

# default_value
require_jenkins_restart=false

# Install Jenkins if not installed
# Mark Jenkins restart if Jenkins not installed
jenkins_installed_check_output=$(dpkg -l | egrep '^ii *jenkins *')
if [ "$jenkins_installed_check_output" != "" ]; then
  jenkins_first_install=false
else
  jenkins_first_install=true
  bash install-software.sh
  require_jenkins_restart=true
fi

# Install Jenkins plugins if not installed
# Mark Jenkins restart if plugins not installed
cd /var/lib/jenkins/plugins
mv /home/vagrant/jenkins/plugins.list .
chown jenkins:jenkins plugins.list
echo "--- INSTALL JENKINS PLUGINS START ---"
while read plugin; do
  if [ ! -f $plugin.hpi ]; then
    echo Download $plugin
    wget -q http://mirror.serverion.com/jenkins/plugins/$plugin/latest/$plugin.hpi
    chown jenkins:jenkins $plugin.hpi
    require_jenkins_restart=true
  fi
done < plugins.list
echo "--- INSTALL JENKINS PLUGINS END ---"

# Set Admin user login and password on first install
if [ $jenkins_first_install = true ]; then
  mkdir -p /var/lib/jenkins/init.groovy.d
  envsubst < /home/vagrant/jenkins/basic-security-template.groovy > /var/lib/jenkins/init.groovy.d/basic-security.groovy
  chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d/

fi

if [ $require_jenkins_restart = true ]; then
  echo "Restart Jenkins"
  sudo service jenkins restart
fi

if [ $jenkins_first_install = true ]; then
  wget http://localhost:8080/jnlpJars/jenkins-cli.jar -t 30 --waitretry=2 --retry-connrefused --retry-on-http-error=503
  rm -f jenkins-cli.jar
  rm -f /var/lib/jenkins/init.groovy.d/basic-security.groovy
fi

