Vagrant.configure("2") do |config|
  config.vm.box = "trusty64"
  config.vm.provision :shell, :path => "provisions/setup.sh"
  # config.vm.network :forwarded_port, guest: 80, host: 8000
  config.vm.network "private_network", ip: ENV['Vagrant_IP']

  config.vm.synced_folder ".", "/vagrant", :mount_options => ['dmode=777,fmode=777']

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--cpus", "1"]
    vb.memory = 1024
  end

  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end
end