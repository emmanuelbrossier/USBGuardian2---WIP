#!/bin/bash

#Ejection de la clé USB
sudo umount /mnt/usb

#Kill le clamscan si il tourne lorsque la clé USB est retirée avant la fin de l'analyse
sudo killall clamscan

#Vider le report de la clé USB
sudo truncate -0 /opt/USBGuardian/logs/report.log
