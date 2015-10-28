#!/bin/sh
###################################################################################
# Development tools should have been installed.
curl --silent --location https://rpm.nodesource.com/setup | bash -
yum -y install nodejs
npm install request

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

pushd /vagrant
 cp dcat_service /etc/init.d
 cp start_dcat-ap_validator.sh /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/pages
 cp dcat.js.config /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/pages/js/concat/dcat.js
 chmod +x /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/pages/start_dcat-ap_validator.sh
 chkconfig --add dcat_service
 service dcat_service start
popd

