# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "box-cutter/centos67-desktop"
  
  # Attempt to cache downloaded files (only if plugin is present).

  if Vagrant.has_plugin?("vagrant-cachier")
     config.cache.scope = :box
  end

  config.vm.provision :shell, path: "bootstrap.sh"
  
  config.vm.network "private_network", ip: "192.168.0.20", :netmask => "255.255.255.0"
  
  config.vm.provider "virtualbox" do |vb|
      vb.name = "vagrant-dcat-ap-validator"
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", 4096]
      vb.customize ["modifyvm", :id, "--vram", 64]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
      vb.memory = "4096"
  end
end
