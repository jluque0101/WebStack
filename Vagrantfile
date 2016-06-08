Vagrant.configure('2') do |config|

  config.vm.define "localhost" do |l|
    l.vm.hostname = "localhost"
    l.vm.box = 'azure'
    l.vm.network "public_network"
    l.vm.network "private_network",ip: "192.168.56.10", virtualbox__intnet: "vboxnet0"
    l.vm.network "forwarded_port", guest: 8000, host: 8000

    l.vm.provider :azure do |azure, override|
 	azure.mgmt_certificate = File.expand_path('/home/jose/claves/azure.pem')
 	azure.mgmt_endpoint = 'https://management.core.windows.net'
 	azure.subscription_id = '5748f1ee-1ca8-4749-b2d3-739d2747f319'
 	azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_3-LTS-amd64-server-20151218-en-us-30GB'
 	azure.vm_name = 'rsmap'
  azure.cloud_service_name = 'rsmap'
  azure.vm_user = 'jose'
  azure.vm_password = 'jose'
 	azure.vm_location = 'Central US'
 	azure.ssh_port = '22'
  azure.tcp_endpoints = '8000:8000'

  config.ssh.username = 'jose'
  config.ssh.password = 'jose'

 	end
     l.vm.provision "ansible" do |ansible|
    	ansible.sudo = true
    	ansible.playbook = "rsmapdeploy.yml"
    	ansible.verbose = "vvv"
    	ansible.host_key_checking = false
  	end
 end
end
