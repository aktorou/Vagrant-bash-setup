Vagrant.configure("2") do |config|
  config.vm.box = "trusty64"

  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  config.vm.provision :shell, :path => "provisions/setup.sh"
  # config.vm.network :forwarded_port, guest: 80, host: 8000
  config.vm.network "private_network", ip: ENV['Vagrant_IP']


  config.vm.synced_folder "Code", "/var/www", :mount_options => ['dmode=777,fmode=777']
  config.vm.synced_folder "logs", "/var/log", :mount_options => ['dmode=777,fmode=777']

  # config.vm.synced_folder ".", "/vagrant", type: "rsync", :mount_options => ["vers=3.02","mfsymlinks","dmode=777,fmode=777"]
  # config.vm.synced_folder ".", "/vagrant", :mount_options => ['dmode=777,fmode=777']
  # config.vm.synced_folder "logs", "/../../var/log/", :mount_options => ['dmode=777,fmode=777']

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--cpus", "1"]
    vb.memory = 1024
  end

  

  # config.vm.provider "virtualbox" do |v|
  #   v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  # end
end