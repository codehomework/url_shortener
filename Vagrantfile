Vagrant.configure(2) do |config|
  config.vm.box = "geerlingguy/centos7"
  config.vm.synced_folder ".", "/home/vagrant/urlshortener" #, type: "nfs"
  # config.vm.network "private_network", type: "dhcp"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  if (/darwin/ =~ RUBY_PLATFORM) != nil
    ram_as_bytes = /(hw.memsize: )(\d*)/.match(`sysctl hw.memsize`)[2].to_i
    ram_as_megabytes = ram_as_bytes/1024/1024 #a.k.a., bytes/kilobytes/megabytes
    vm_ram = ram_as_megabytes/2
    cpu_core_count = /(hw.physicalcpu: )(\d*)/.match(`sysctl hw.physicalcpu`)[2].to_i
    vm_cpu_cores = cpu_core_count-1
    config.vm.provider "virtualbox" do |box|
      box.cpus = vm_cpu_cores
      box.memory = vm_ram
    end
  end
  config.vm.provision "shell", privileged: false, path: "provisioner.sh"
end
