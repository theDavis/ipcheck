#!/bin/bash
set -e
MTA=${1}
EMAIL=${2}

function usage()
{
	echo "usage: ipcheck.sh sendmail address@host"
}

if [ "${MTA}" == "" ] || [ "${EMAIL}" == "" ]; then
	usage
	exit 1
fi

OLD_IP=$(cat ip.txt)
NEW_IP=$(curl -s ipinfo.io/ip)

if [ "${NEW_IP}" != "${OLD_IP}" ]; then
	echo "IP changed from ${OLD_IP} to ${NEW_IP}" | ${MTA} ${EMAIL}
fi

echo ${NEW_IP} > ip.txt
