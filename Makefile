mpassword=VERY_SECRET_MYSQL_PASSWORD_HERE
SSHKEY=~/Sites/Keys/Eduards_AWS.pem

prepare:
	cd ./Terraform && terraform init 
	cd ./Terraform && terraform plan -var-file="terraform.tfvars"

provision-status:
	cd ./Terraform && terraform refresh -var-file="terraform.tfvars"

provision-up:
	cd ./Terraform && terraform apply -var-file="terraform.tfvars"

provision-down:
	cd ./Terraform && terraform destroy -var-file="terraform.tfvars"

ssh1:
	ssh -i $(SSHKEY) centos@18.194.166.4 -p 22

ssh2:
	ssh -i $(SSHKEY) centos@3.120.13.137 -p 22

ssh3:
	ssh -i $(SSHKEY) centos@52.58.96.28 -p 22

ssh4:
	ssh -i $(SSHKEY) centos@52.58.7.128 -p 22

mariadb-install:
	cd ./Ansible && ansible-playbook -i hosts maria.yml --extra-vars "mysql_root_password=$(mpassword)" --ssh-common-args='-o StrictHostKeyChecking=no'

mariadb-status:
	cd ./Ansible && ansible -i hosts aws_servers -m service -a 'name=mariadb state=started'

galera-install:
	cd ./Ansible && ansible-playbook -i hosts galera_install.yml --extra-vars "mysql_root_password=$(mpassword)" --ssh-common-args='-o StrictHostKeyChecking=no'

galera-start:
	cd ./Ansible && ansible-playbook -i hosts galera_start.yml --extra-vars "mysql_root_password=$(mpassword)" --ssh-common-args='-o StrictHostKeyChecking=no'

galera-join:
	cd ./Ansible && ansible-playbook -i hosts galera_join.yml --extra-vars "mysql_root_password=$(mpassword)" --ssh-common-args='-o StrictHostKeyChecking=no'