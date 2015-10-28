#!/usr/bin/env bash
yum -y install epel-release
yum -y install wget dos2unix
wget -N http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release-6*.rpm
wget -N http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-13.ius.centos6.noarch.rpm
rpm -Uvh ius-release*.rpm
yum -y update
    # Install GIT and the network time server
yum -y install git ntp 

    # Install GUI tools
yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"
yum -y groupinstall "Graphical Administration Tools"
yum -y groupinstall "Internet Browser"
yum -y groupinstall "General Purpose Desktop"
yum -y groupinstall "Office Suite and Productivity"
yum -y groupinstall "Graphics Creation Tools"

# Check boot init
sed -i -e 's/:3:/:5:/g' /etc/inittab

# Install decent editor and browser
yum -y install emacs
yum -y install firefox

# Setup for the guest additions, etc.
yum -y --enablerepo rpmforge install dkms
yum -y groupinstall "Development Tools"
yum -y install binutils gcc gcc-c++ make patch libgomp glibc-headers glibc-devel \
    kernel-headers kernel-devel

###################################################################################
# Development tools should have been installed.

curl --silent --location https://rpm.nodesource.com/setup | bash -
yum -y install nodejs

###################################################################################
# Setup the DCAT validator

mkdir -p /var/local/dcat-ap_validator
pushd /var/local/dcat-ap_validator
 wget -N http://archive.apache.org/dist/jena/binaries/jena-fuseki1-1.1.2-distribution.zip
 unzip jena-fuseki1-1.1.2-distribution.zip
 cd jena-fuseki1-1.1.2
 unzip -o /vagrant/dcat-ap_validator_v1.1.0.zip
popd

###################################################################################
# Set up the DCAT validator to restart as a service

cp /vagrant/dcat_service /etc/init.d
cp /vagrant/start_dcat-ap_validator.sh /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/pages
cp /vagrant/dcat-ap_validator.js.config /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/pages/js/dcat-ap/dcat-ap_validator.js
chmod +x /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/pages/start_dcat-ap_validator.sh
chkconfig --add dcat_service
service dcat_service start

###################################################################################
# Change the default homepage
echo "user_pref(\"browser.startup.homepage\", \"http://localhost:3000/dcat-ap_validator.html\");" >> /etc/firefox/syspref.js

# Everything should be finished
echo "****** done with bootstrap of LODMS machine"
