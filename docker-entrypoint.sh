#!/bin/bash

if [ ! "${ROOT_PASSWORD}" ]
then
  ROOT_PASSWORD=$(tr -c -d '0123456789abcdefghijklmnopqrstuvwxyz' </dev/urandom | dd bs=32 count=1 2>/dev/null)
fi

echo "root:${ROOT_PASSWORD}" | chpasswd

echo Starting...

systemctl start dsm_om_connsvc
systemctl start dsm_sa_snmpd
systemctl start dsm_sa_datamgrd
systemctl start dsm_sa_eventmgrd

echo
echo ===========================================================================
echo
echo OpenManage Login: "root:${ROOT_PASSWORD}"
echo
echo ===========================================================================
echo

tail -n 0 -f $(find /opt/dell/srvadmin/var/log -type f)
