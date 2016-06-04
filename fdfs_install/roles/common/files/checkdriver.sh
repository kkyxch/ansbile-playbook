#!/bin/bash
#$Id: check_perc5i.sh, v0.2 2008/4/15 weithenn Exp $
#Check RAID Card PERC 5/i VD and PD State
HOSTNAME=`/bin/hostname`
DATE=`date +%F" "%T`
CARD=`/usr/sbin/MegaCli -AdpAllInfo -aALL |grep "Product Name" | awk -F":" '{print $NF}'`
VDSTATE1=`/usr/sbin/MegaCli -cfgdsply -aALL | grep "State"`
VDSTATE2=`/usr/sbin/MegaCli -AdpAllInfo -aALL | grep "Degraded"`
VDSTATE3=`/usr/sbin/MegaCli -AdpAllInfo -aALL | grep "  Offline"`
PDSTATE1=`/usr/sbin/MegaCli -cfgdsply -aALL | grep "Online" | wc -l | sed 's/       //'`
PDSTATE2=`/usr/sbin/MegaCli -cfgdsply -aALL | grep "Rebuild" | wc -l | sed 's/       //'`
PDSTATE3=`/usr/sbin/MegaCli -AdpAllInfo -aALL | grep "Critical Disks"`
PDSTATE4=`/usr/sbin/MegaCli -AdpAllInfo -aALL | grep "Failed Disks"`
PDSTATE5=`/usr/sbin/MegaCli -AdpAllInfo -aALL | grep "Failed Disks"|awk '{print $NF}'`
> /tmp/test
echo "##### Check Time #####" >> /tmp/test
echo "Current Time is   :$DATE" >> /tmp/test
echo "" >> /tmp/test
echo "##### Host Informationi #####" >> /tmp/test
echo "Host              : $HOSTNAME" >> /tmp/test
echo "Raid Card         :$CARD" >> /tmp/test
echo "" >> /tmp/test
echo "##### Virtual Disk State #####" >> /tmp/test
echo "Virtual Disk $VDSTATE1" >> /tmp/test
echo "$VDSTATE2" >> /tmp/test
echo "$VDSTATE3" >> /tmp/test
echo "" >> /tmp/test
echo "##### Physical Disk State #####" >> /tmp/test
echo "Online Disk       : ${PDSTATE1}" >> /tmp/test 2>&1
echo "Rebuild Disk      : ${PDSTATE2}" >> /tmp/test 2>&1
echo "$PDSTATE3" >> /tmp/test
echo "$PDSTATE4" >> /tmp/test
