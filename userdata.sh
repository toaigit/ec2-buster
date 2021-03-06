#!/bin/bash
echo "Start System Admin Userdata ..."
/bin/timedatectl set-timezone America/Los_Angeles
/bin/domainname "amazon.stanford.edu"
/bin/hostname "buildec2"
echo PS1=\"[\\\\u@buildec2]\" >> /etc/bashrc

#
apt-get update

#  install git required since we need to pull down the cloudinit scripts
apt-get install -y git unzip jq rsync

# python and nodejs are popular tool so installing it
apt-get install -y python3-pip python-pip
apt-get install -y nodejs npm

# install gomplate
curl -s -o /usr/local/bin/gomplate -sSL https://github.com/hairyhenderson/gomplate/releases/download/v3.6.0/gomplate_linux-amd64
chmod 755 /usr/local/bin/gomplate

#  install terraform
curl -s -o /usr/local/bin/terraform.zip https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
cd /usr/local/bin
unzip terraform.zip

# install vault
curl -s -o /usr/local/bin/vault.zip https://releases.hashicorp.com/vault/1.3.4/vault_1.3.4_linux_amd64.zip
cd /usr/local/bin
unzip vault.zip

# install java
curl -o /tmp/jdk.tar.gz -sSL https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz
mkdir /opt/java
cd /opt/java
tar -xzvf /tmp/jdk.tar.gz
cd /opt/java
JAVA_DIR=`ls -l  | grep corretto | awk '{print $9}'`
ln -s $PWD/$JAVA_DIR latest

#  Pull down the cloud init code to /tmp folder
cd /tmp
git clone https://gitlab.com/toaivo/ec2-scripts.git

#  Passing EBS, EIP information to Instance
/bin/echo "ebs /apps appadmin ${apps_vol}" | tee /tmp/EBS.list
/bin/echo "${my_eip_id}" | tee /tmp/EIP.list
/bin/echo "appadmin,1001" | tee /tmp/USERS.list
/bin/echo -e "run.eip\nrun.crusers\nrun.ebs" > /tmp/build.txt

#  Executing the cloud init script (runcmd)
cd /tmp/ec2-scripts
/tmp/ec2-scripts/runcmd | tee /tmp/runcmd.log
