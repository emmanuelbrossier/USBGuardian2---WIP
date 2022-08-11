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
