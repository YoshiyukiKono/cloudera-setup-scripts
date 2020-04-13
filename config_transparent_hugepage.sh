#!/bin/bash -x

#LOG_FILE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`.log
#exec > ./$LOG_FILE 2>&1

cp /etc/rc.d/rc.local ./rc.local.bak
#TODO condition
echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.d/rc.local 
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" >> /etc/rc.d/rc.local 
sed -i.bak -e 's/^\(GRUB_CMDLINE_LINUX="[^"]*\)/\1 transparent_hugepage=never/' /etc/default/grub

cat /etc/rc.d/rc.local
cat /etc/default/grub

grub2-mkconfig -o /boot/grub2/grub.cfg
#reboot
