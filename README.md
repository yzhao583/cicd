Prerequisites:
- Ansible installed on the local
- Install docker role on the local from Ansible galaxy using following command:
	ansible-galaxy install marvinpinto.docker
	ansible-galaxy install franklinkim.docker-compose

Under env directory:
1 - Modify ansible/hosts/hosts (domain name/ip) and cd/yml (hosts and remote_user) files according to your needs

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

	You can ssh in using ssh vagrant@192.168.50.91


