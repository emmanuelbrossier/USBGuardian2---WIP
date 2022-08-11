#!/bin/bash

#Aller dans le dossier de la clé USB
cd /mnt/usb
percentage=0
sDuration=2.4

#Récupérer le nombre total de fichiers présents sur la clé USB
total=$(find . -type f | wc -l)

#Début de l'écoute de la progression du scan ClamAV
while true
do

        #Rafraichissement du nombre total de fichier dans la clé USB présente
        totalRealTime=$(find . type f | wc -l)
        #Obtention du nombre de fichiers scannés par ClamAV
        current=$(grep -o "OK\|FOUND\|Empty\|ERROR" /opt/UsbGuardian/logs/lastAnalysis.log | wc -l)
        #Obention du nombre de fichiers supprimés par ClamAV s'il positif
        filesRemoved=$(grep -o "Removed" /opt/USBGuardian/logs/lastAnalysis.log | wc -l)
        #Soustraction du nombre de fichiers supprimés au nombre total de fichiers
        current=$((current - filesRemoved))
        totalR=$((total - filesRemoved))
