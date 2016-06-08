install:
	pip install -r requirements.txt

test:
	python manage.py test

docker-install:
	sudo apt-get update
	sudo apt-get install -y docker.io
	sudo apt-get install -y apparmor lxc cgroup-lite
	sudo usermod -aG docker ${USER}
	sudo docker -d &
	sudo docker pull luqueburgosjm/rsmapweb
	sudo docker run -i -t luqueburgosjm/rsmapweb /bin/bash

docker:
	sudo apt-get install -y python python-dev python-distribute python-pip
	sudo apt-get install -y python2.7-dev
	pip install -r requirements.txt
	python manage.py migrate

run:
	python manage.py runserver 0.0.0.0:8080 &

heroku-deploy:
	wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
	heroku login
	heroku create
	git add .
	git commit -m "Desplegando en Heroku"
	git push heroku master
	heroku ps:scale web=1
	heroku open

azure-install:
	sudo apt-get install -y fabric
	sudo apt-get install -y virtualbox
	sudo apt-get install -y virtualbox-dkms
  wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
	sudo dpkg -i vagrant_1.8.1_x86_64.deb
	vagrant plugin install vagrant-azure
	sudo apt-get install -y python-pip
	sudo pip install --upgrade pip
	sudo pip install paramiko PyYAML jinja2 httplib2 ansible
	sudo vagrant box add azure https://github.com/msopentech/vagrant-azure/raw/master/dummy.box --force

azure-deploy:
	vagrant up --provider=azure

azure-provision:
	vagrant provision
