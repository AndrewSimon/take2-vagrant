# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
#  config.vm.box = "centos-65-i386"
 config.vm.box = "centos-6.5-x86_64"
 config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140110.box"

  #config.vm.boot_mode = :gui

## Very little resources in my tiny vbox
  config.vm.provider "virtualbox" do |v|
	v.customize [ "modifyvm", :id, 
			"--name", "centos-65-i386", 
			"--memory", "256"
                      ]
  end

  config.vm.network "public_network"

  config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "init.pp"
  end
end
