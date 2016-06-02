Prerequisites:
- Ansible installed on the local
- Install docker role on the local from Ansible galaxy using following command:
	ansible-galaxy install marvinpinto.docker
	ansible-galaxy install franklinkim.docker-compose

Under env directory:
1 - Modify cd.yml file and replace the "remote_user" with the user you'll be using.

2 - Create your RSA Key Pair:
	The first step is to create the key pair on the client machine (there is a good chance that this will just be your computer):
		ssh-keygen -t rsa

3 - Copy the Public Key
	Once the key pair is generated, it's time to place the public key on the virtual server that we want to use.

	You can copy the public key into the new machine's authorized_keys file with the ssh-copy-id command. Make sure to replace the example username and IP address below.

	ssh-copy-id user@remote_host
	Alternatively, you can paste in the keys using SSH:

	cat ~/.ssh/id_rsa.pub | ssh username@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

	cat ~/.ssh/id_rsa.pub | ssh vagrant@192.168.50.91 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"

4 - Secure the server:
	ansible-playbook -i ansible/hosts -s -u vagrant ansible/secure-server.yml

5 - Create cicd-user:
	If we already have a cicd user, you can skip this step
	Note: This sitep is currently part of sercure server. Needs to be separated as a role.

6 - Optional Step Four—Disable the Password for Root Login
	Once you have copied your SSH keys unto your server and ensured that you can log in with the SSH keys alone, you can go ahead and restrict the root login to only be permitted via SSH keys.

	In order to do this, open up the SSH config file:

	sudo nano /etc/ssh/sshd_config
	Within that file, find the line that includes PermitRootLogin and modify it to ensure that users can only connect with their SSH key:

	PermitRootLogin without-password
	Put the changes into effect:

	reload ssh

5 - Test Ansible:
	- The command below assumes you can already authenticate to your server using the root account with public key authentication:
		ansible -i ansible/hosts cicd -m ping -u vagrant
	- If this is not the case, you can use the ‘-u’ option to specify a different account name and ‘-k’ to ask Ansible to prompt you for an SSH password
		ansible cicd -i ansible/hosts -m ping -u vagrant -k

	You should see response like this:

	192.168.50.91 | success >> {
	    "changed": false,
	    "ping": "pong"
	}

6 - Provision the CICD host:
	# ansible-playbook -i ansible/hosts -s -u vagrant ansible/cd.yml
	ansible-playbook -i ansible/hosts -s ansible/cd.yml
	ansible-playbook -i 192.168.50.91, ansible/cd.yml
	ansible-playbook -i cicd.cloudapp.net, ansible/cd.yml

7 - ssh in:
	ssh vagrant@192.168.50.91
	ssh cicduser@cicd.cloudapp.net



ssh-keygen -R hostname
ssh-keygen -R 192.168.50.91

======================================
How to enable Docker Remote API:

sudo vi /etc/init/docker.conf

DOCKER_OPTS="-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock"

sudo service docker restart

-----------

killercentury/jenkins-slave-dind

-----------
Docker Machine notes
docker-machine create \
    --driver=generic \
    --generic-ip-address=IP_ADDRESS \
    --generic-ssh-user=USERNAME \
    --generic-ssh-key=PATH_TO_SSH_KEY \
    --generic-ssh-port=PORT \
        MACHINE_NAME


docker-machine create -d generic \
--generic-ssh-user ubuntu \
--generic-ssh-key ~/Downloads/manually_created_key.pub \
--generic-ip-address 12.34.56.78 \
jungle



docker-machine ls


$ docker-machine env default
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://172.16.62.130:2376"
export DOCKER_CERT_PATH="/Users/<yourusername>/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"
# Run this command to configure your shell:
# eval "$(docker-machine env default)"

eval "$(docker-machine env default)"

docker run busybox echo hello world

docker-machine stop default
docker-machine start default