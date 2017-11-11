#!/bin/bash

domain="example.com"
awk 'match($0,v){print NR; exit}' v=$domain /opt/cfDDNS/list.sh #gets line number

#needs code to remove the line from the file