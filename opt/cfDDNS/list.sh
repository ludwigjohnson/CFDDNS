#!/bin/bash

#Example
#$(home/USER/bin/cfDDNS/updateDNS.sh "CloudflareEmail" "CloudflareAPIkey" "CloudflareZoneID" "DOMAIN/SUBDOMAIN" "CloudflareDomainRecordID" "TTLinSeconds" "proxied" "ipProvider")
#$(home/test/bin/cfDDNS/updateDNS.sh "email@example.com" "abc123321cba" "cba456321cba" "temp.example.com" "123456abccba" "120" "false" "1") ###### last parameter is 1 for DNS challenge via openDNS or any domain that will respond only with the IP via cURL
#$(home/test/bin/cfDDNS/updateDNS.sh "email@example.com" "abc123321cba" "cba456321cba" "dev.example.com" "abc123cba432" "1" "true" "ipinfo.io/ip")
