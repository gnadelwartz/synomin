#!bin/sh
# reset webmin config
WEBMIN="/var/packages/webmin/target"
cp -r $WEBMIN/reset/* $WEBMIN
