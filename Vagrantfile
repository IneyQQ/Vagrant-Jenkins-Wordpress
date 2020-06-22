# -*- mode: ruby -*-
# vi: set ft=ruby :
#

jenkins_admin_username = ENV['jenkins_admin_username'] || 'admin'
jenkins_admin_password = ENV['jenkins_admin_password'] || 'Passw0rd'
wp_mysql_username = ENV['wp_mysql_username'] || 'wordpress'
wp_mysql_password = ENV['wp_mysql_password'] || 'Passw0rd_'
wp_mysql_root_password = ENV['wp_mysql_root_password'] || 'Passw0rd_'
wp_mysql_dbname = ENV['wp_mysql_dbname'] || 'wordpress'

Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |config|
    config.vm.box = "bento/ubuntu-20.04" # "ubuntu/xenial64"
    
    config.vm.network "private_network", ip: "192.169.0.2"
    config.vm.network "forwarded_port", guest: 8080, host: 8080, protocol: "tcp"
    config.vm.hostname = "jenkins.issoft.dev"

    config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = "4096"
    end

    config.vm.provision "file", source: "jenkins", destination: "~/jenkins"
    config.vm.provision "shell" do |shell|
      shell.env = {
        "JENKINS_ADMIN_USERNAME" => jenkins_admin_username,
        "JENKINS_ADMIN_PASSWORD" => jenkins_admin_password
      }
      shell.inline = <<-jenkins
        cd /home/vagrant/jenkins
        bash jenkins.sh
      jenkins
    end
  end
  config.vm.define "wordpress" do |config|
    config.vm.box = "centos/7"

    config.vm.network "private_network", ip: "192.169.0.3"
    config.vm.hostname = "wordpress.issoft.dev"

    config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 1
      vb.memory = "1024"
    end

    config.vm.provision "file", source: "wordpress", destination: "~/wordpress"
    config.vm.provision "shell" do |shell|
      shell.env = {
        "MYSQL_USERNAME" => wp_mysql_username,
        "MYSQL_PASSWORD" => wp_mysql_password,
        "MYSQL_ROOT_PASSWORD" => wp_mysql_root_password,
        "MYSQL_DBNAME" => wp_mysql_dbname
      }
      shell.inline = <<-jenkins
        cd /home/vagrant/wordpress
        bash wordpress.sh
      jenkins
    end
  end
end

