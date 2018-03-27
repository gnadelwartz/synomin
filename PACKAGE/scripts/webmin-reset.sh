#!/bin/sh
# reset webmin config
WEBMIN="/var/packages/webmin/target"
cp -rL $WEBMIN/reset/* $WEBMIN
$WEBMIN/etc/restart

