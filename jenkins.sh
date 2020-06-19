#!/bin/bash
echo "Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

echo "Updating apt-get"
sudo apt-get -qq update

echo "Installing default-java"
sudo apt-get -y install default-jre > /dev/null 2>&1
sudo apt-get -y install default-jdk > /dev/null 2>&1

echo "Installing git"
sudo apt-get -y install git > /dev/null 2>&1

echo "Installing git-ftp"
sudo apt-get -y install git-ftp > /dev/null 2>&1

jenkins_installed_check_output=$(dpkg -l | egrep '^ii *jenkins *')
if [ "$jenkins_installed_check_output" != "" ]; then
  jenkins_installed_before=true
else
  jenkins_installed_before=false
  echo "Installing jenkins"
  sudo apt-get -y install jenkins > /dev/null 2>&1
fi

cd /var/lib/jenkins/plugins
plugins=(
	ace-editor
	antisamy-markup-formatter
	ant
	apache-httpcomponents-client-4-api
	bouncycastle-api
	branch-api
	build-timeout
	command-launcher
	cloudbees-folder
	credentials-binding
	credentials
	display-url-api
	durable-task
	email-ext
	git-client
	github-api
	github-branch-source
	github-organization-folder
	github
	git
	git-server
	gradle
	handlebars
	jackson2-api
	jaxb
	jdk-tool
	jquery-detached
	jsch
	junit
	ldap
	lockable-resources
	mapdb-api
	matrix-project
	matrix-auth
	mailer
	momentjs
	pam-auth
	pipeline-build-step
	pipeline-github-lib
	pipeline-graph-analysis
	pipeline-input-step
	pipeline-milestone-step
	pipeline-model-api
	pipeline-model-definition
	pipeline-model-extensions
	pipeline-rest-api
	pipeline-stage-step
	pipeline-stage-tags-metadata
	pipeline-stage-view
	plain-credentials
	okhttp-api
	resource-disposer
	scm-api
	script-security
	ssh-credentials
	ssh-slaves
	structs
	subversion
	timestamper
	token-macro
	trilead-api
	workflow-aggregator
	workflow-api
	workflow-basic-steps
	workflow-cps
	workflow-cps-global-lib
	workflow-durable-task-step
	workflow-job
	workflow-multibranch
	workflow-scm-step
	workflow-step-api
	workflow-support
	ws-cleanup
)
require_jenkins_restart=false
echo "Download Jenkins Plugins"
for plugin in ${plugins[@]}; do
  if [ ! -f $plugin.hpi ] && [ ! -f $plugin.jpi ]; then
    echo Download $plugin
    wget -q https://mirrors.tuna.tsinghua.edu.cn/jenkins/plugins/$plugin/latest/$plugin.hpi
    chown jenkins:jenkins $plugin.hpi
    require_jenkins_restart=true
  fi
done

sudo service jenkins start

if [ $require_jenkins_restart = true ]; then
  sudo service jenkins restart
fi

if [ $jenkins_installed_before = false ]; then
  sleep 1m
  
  echo "Installing Jenkins Plugins"
  JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
  echo $JENKINSPWD
fi

