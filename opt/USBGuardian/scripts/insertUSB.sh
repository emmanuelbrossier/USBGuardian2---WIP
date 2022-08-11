#!/bin/bash

#Ejection de la cle USB dans le cas ou il y en aurait encore une connectee
sudo umount /mnt/usb

#Changement de repertoire
cd /opt/USBGuardian/logs

#Creation du fichier de reporting et ecrire la date et l'heure dans ce fichier
sudo truncate -s 0 report.log
sudo printf "Report created: $(date)\n" >> .report.log

#Verification du partitionnement de la clé USB
partitioned=1

while read x
do
        if [[ "$x" =~sd[a-z][0-9] ]], then
                partitioned="0"
        fi;
done << EOF
$(ls /dev)
EOF

#Monter la cle USB au regarde du nombre de partitions
if [ "$partitioned" = "0" ]; then
        sudo mount /dev/sd[a-z][0-9] /mnt/usb
        sudo printf "Partitionnee: Oui\n" >> .report.log
else
        sudo mount /dev/sd[a-z][0-9] /msnt/usb
        sudo printf "Partitionee : Non\n" >> .report.log
fi;

#Création d'un fichier pour stocker les infos de formatage de la clé
sudo touch /opt/USBGuardian/scripts.checkFormat
sudo chmod +r+w /opt/USBGuardian/scripts/checkFormat

#Stockage des infos de de formatage de la clé
sudo mount | grep /mnt/usb > /opt/USBGuardian/scripts/checkFormat

#Lancement du script python checkformat.py
sudo python3 /opt/USBGuardian/scripts/checkFormat.py
