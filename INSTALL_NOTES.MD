

### Prepare setup

Install and configure all required tools for this challenge

~~~sh

# install aws cli on mac
brew install awscli

# configure access with api keys
aws configure

# login
$(aws ecr get-login --no-include-email --region eu-central-1)

# setup terraform 
brew install terraform

# upgrade to latest version
brew upgrade terraform

# install ansible
brew install ansible


~~~

### Terraform AWS instance provisioning

~~~sh
# got to terraform folder
cd Terraform

# initialize terraform with AWS plugin
terraform init 

terraform plan -var-file="terraform.tfvars"

terraform apply -var-file="terraform.tfvars"


~~~

### Install MariDB manually

~~~sh
sudo yum install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl status mariadb

sudo mysql_secure_installation
Enter current password for root (enter for none): 
Set root password? [Y/n] js7zOfH2f6ohXgvhJZE5
Remove anonymous users? [Y/n] y
Disallow root login remotely? [Y/n] y
Remove test database and access to it? [Y/n] y
Reload privilege tables now? [Y/n] y
~~~

### Install MAriaDB Galera manually

~~~
sudo su

yum update -y

# Change SELINUX=enforcing to SELINUX=disabled
# restart required or sudo setenforce 0
vi /etc/selinux/config


vi /etc/yum.repos.d/mariadb.repo

[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.2.9/centos7-amd64/
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1


yum install mariadb-server mariadb-client galera rsync -y

systemctl start mariadb
mysql_secure_installation
systemctl stop mariadb

vi /etc/my.cnf.d/server.cnf

[galera]
wsrep_on=ON
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
#add your node ips here
wsrep_cluster_address="gcomm://3.120.13.137,52.58.96.28,52.58.7.128"
binlog_format=row
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
#Cluster name
wsrep_cluster_name="clustername"
# Allow server to accept connections on all interfaces.
bind-address=0.0.0.0
# this server ip, change for each server
wsrep_node_address="52.58.7.128"
# this server name, change for each server
wsrep_node_name=”node3"
wsrep_sst_method=rsync

# node 1
galera_new_cluster

# node 2 and 3
systemctl start mariadb

mysql -u root 

SHOW STATUS LIKE "wsrep_cluster_size";


~~~