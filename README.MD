# MariaDB setup with Ansible 

### Description

Automated MariaDB setup in AWS with Ansible and 
Terraform.

MariaDB in single instance mode.

MariaDB in Multi master-to-master replication mode (Galera cluster)

Daily backup scipt is set up in cron 

Tested with AWS Centos 7 and Digitalocean Centos 7 images.


### Requirements

- AWS account
- Ansible installed
- Terraform installed
- Make package installed

### File structure

~~~
Ansible - Folder with ansible configs, templates and scripts
Ansible/scripts/backup.sh - Mysql database backup script
Terraform - Terraform configuration files
README.MD - Project readme
Makefile - Command shortcuts using Make
INSTALL_NOTES.MD - Manual install notes
~~~

### Change config before starting

1. AWS access keys in Terraform/terraform.tfvars
2. Edit Ansible/hosts file, enter Server IP addresses
3. Edit Terraform/variable.tf
 - AWS region
 - Instance type
 - SSH key path
 - Reserved Elastic IPs
 
4. Edit Makefile 
 - Mysql password
 - SSH key path
 - IP addresses for servers

### Setup Infrastructure

~~~sh
# initialize Terraform setup
make prepare

#  Provision infrastructure in AWS, confirm with "yes"
make provision-up

# To delete all servers, confirm with "yes"
make provision-down

~~~

### Install MariaDB single instance

~~~sh
# install mariadb
make mariadb-install

# check if maridb is running
make mariadb-status

~~~

### Install MariaDB Galera in HA mode

Multi master to master replication setup.

~~~sh
# At first setup MariaDB on each nodes and stop them
make galera-install

# Start Galera cluster on first node
make galera-start

# Join other nodes to cluster
make galera-join
~~~