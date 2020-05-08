unless Vagrant.has_plugin?("vagrant-cachier")
	system("vagrant plugin install vagrant-cachier")
	puts "Dependencies installed, please try the command again."
	exit
end

# host pg1
Vagrant.configure("2") do |cfg|

	cfg.vm.define "pg0" do |pg|
	cfg.vm.provision :shell, :inline => "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl restart sshd;", run: "always"
	cfg.vm.provision :shell, :inline => "sudo mkdir -p ~/.ssh", run: "always"
	cfg.vm.provision :shell, :inline => "sudo touch ~/.ssh/authorized_keys", run: "always"
	cfg.vm.provision :shell, :inline => "sudo chmod 600 ~/.ssh/authorized_keys", run: "always"


		pg.vm.box = "centos/7"
		pg.vm.hostname = "pg0"
		pg.vm.network "private_network", ip: "192.168.56.150"
		pg.vm.box_check_update = true
		pg.vbguest.auto_update = true
		pg.vm.synced_folder ".", "/vagrant", id: "unique_id_1", type: "virtualbox"

		if Vagrant.has_plugin?("vagrant-cachier")
			pg.cache.scope = :box
		end

		pg.vm.provider "virtualbox" do |vb|
			vb.name = "pg0"
			vb.cpus = 1
			vb.memory = "4096"
			vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
			vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
			vb.customize ["modifyvm", :id, "--audio", "none"]
			vb.customize ["modifyvm", :id, "--usb", "off"]
			vb.customize ["modifyvm", :id, "--usbehci", "off"]
			vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--cableconnected2", "on", "--hostonlyadapter2", "vboxnet0"]
			vb.customize ["modifyvm", :id, "--ioapic", "on"]
		end
	end

# Vagrant.configure -> end
end