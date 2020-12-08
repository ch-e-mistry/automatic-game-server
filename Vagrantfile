#VARIABLES
BASE_BOX = "geerlingguy/centos7"
BOX_RAM_MB = "2048"
BOX_1 = "linux_GSM"


Vagrant.configure("2") do |config|
 
  config.vm.define BOX_1 do |gsm|
    gsm.vm.box = BASE_BOX
    gsm.vm.provider "virtualbox" do |vb|
      vb.memory = BOX_RAM_MB
    end
    gsm.vm.network "private_network", ip: "192.168.56.56"
   #C:\Program Files\Oracle\VirtualBox>VBoxManage list bridgedifs
   # gsm.vm.network "public_network", bridge: "Intel(R) Dual Band Wireless-AC 8265"
    gsm.vm.synced_folder "./provision", "/provision"
    gsm.vm.provision "shell", inline: "hostnamectl set-hostname gsm-csgo"
    gsm.vm.provision "shell", path: "provision/os_dependencies.sh"
    gsm.vm.provision "ansible_local" do |ansible|
      ansible.become = true
      ansible.playbook = "provision/gsm.yaml"
      ansible.limit = "all,localhost"
    end
  end
end