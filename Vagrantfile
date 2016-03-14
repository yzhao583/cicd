# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
  end

  config.vm.define :cicd, primary: true do |cicd|
    cicd.vm.network :forwarded_port, host: 8080, guest: 8080  #Jenkins
    cicd.vm.network :forwarded_port, host: 8081, guest: 8081  #Artifactory
    cicd.vm.network :forwarded_port, host: 5000, guest: 5000  #Sonar
    cicd.vm.network :forwarded_port, host: 9000, guest: 9000  #Sonar
    cicd.vm.network :forwarded_port, host: 8153, guest: 8153  #GOCD
    cicd.vm.network :forwarded_port, host: 2201, guest: 22, id: "ssh", auto_correct: true
    cicd.vm.network "private_network", ip: "192.168.50.91"
    cicd.vm.hostname = "cicd"
    
    #cicd.vm.gui = true
    ## Use VBoxManage to customize the VM. For example to change memory:
    #cicd.vm.customize ["modifyvm", :id, "--memory", "4096"]
    #cicd.vm.customize ["modifyvm", :id, "--vram", 64]
    #cicd.vm.customize ["modifyvm", :id, "--accelerate3d", "on"]

  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
end