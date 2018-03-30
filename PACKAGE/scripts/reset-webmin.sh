#!/bin/sh
# reset webmin config
WEBMIN="/var/packages/webmin/target"
/bin/cp -rv $WEBMIN/reset/* $WEBMIN

