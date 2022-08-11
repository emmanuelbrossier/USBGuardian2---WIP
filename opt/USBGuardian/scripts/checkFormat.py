#!/usr/bin/python3.9
#-*- coding:utf-8 -*-

import os
import sys
import re
from statistics import fileCount
from statistics import malwareCount
from statistics import infectedDevicesCount
from statistics import deviceCount
from statistics import totalTimeOfScan

#Verification de la présence d'un autorun sur le support USB
if os.path.isfile("/mnt/usb/Autorun.inf"):
        os.system("sudo mv /mnt/usb/Autorun.inf /mnt/usb/Autorun.inf.MALICIOUS")

#Vider le fichier log
os.system("sudo truncate -s 0 /opt/USBGuardian/logs/lastAnalysis.log")

#Scan de la clé USB
os.system("clamscan -r --verbose /mnt/usb >> /opt/USBGuardian/logs/lastAnalysis.log")

#Mise à jour des statistique de comptage de clé
deviceCount()

#Obtention des logs
with open("/opt/USBGuardian/logs/lastAnalysis.log") as logFile:

        #Copie du log à la fin du report
        os.system("sudo tail -n 10 /opt/USBGuardian/logs/lastAnalysis.log >> /opt/USBGuardian/logs/report/log")

        linesLog = logFile.readlines()
        with open ("/opt/USBGuardian/logs/report.log",'a+') as report:

                #Parcourir le fichier log
                for line in linesLog:

                        #Si la ligne indique un fichier infecté, copie dans le report
                        if "FOUND" in line:
                                report.write(line)

                        #Mise à jour du compteur de fichiers scannés
                        elif re.match("Scanned files:",line):
                                sentence,count = line.split(": ")
                                fileCount(int(count))

                        #Mise à jour des comptes de fichiers infectés et de clés infectées
                        elif re.match("Infected files:",line):
                                sentence,count = line.split(": ")
                                if int(count)>0:
                                        malwareCount(int(count))
                                        infectedDevicesCount()
