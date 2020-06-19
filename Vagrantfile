# -*- mode: ruby -*-
# vi: set ft=ruby :
#


Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |config|
    config.vm.hostname = "jenkins.issoft.dev"
    config.vm.box = "bento/ubuntu-20.04" # "ubuntu/xenial64"
    
    config.vm.network "private_network", ip: "192.169.0.2"
    config.vm.network "forwarded_port", guest: 8080, host: 8080, protocol: "tcp"

    config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = "4096"
    end

    config.vm.provision "shell" do |shell|
      shell.path = "jenkins.sh"
    end
  end
end

