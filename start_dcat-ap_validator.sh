#!bin/bash
( cd /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/pages ; 
  java -jar /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/fuseki-server.jar --update --port=3000 --pages /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/pages --mem /dcat-ap_validator &
  node /var/local/dcat-ap_validator/jena-fuseki1-1.1.2/server.js 3000 sessions.json 1 localhost 3000 dcat-ap_validator > /var/log/dcat-ap-server.log )
