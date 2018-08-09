#!/bin/bash

# Logfile
log="$HOME/bin/cfDDNS/cloudflare_updates.log"

# Variables
auth_email="$1" #CF email
auth_key="$2" #CF API key
zone_id="$3" #CF Zone ID
zone_name="$4" # CF Zone name (subdomain: sub.example.com)
zone_record_id="$5" # ID of A/CNAME/etc record

# Settings
record_type="A" #A,CNAME,etc
record_ttl="$6" #In seconds (1 = auto) - If record_proxied = true, TTL defaults to automatic on CF servers
record_proxied="$7" #Proxy record (use for A/CNAME - not MX etc)
record_content="10.10.10.10" #Private IP - keep default to get current hosts external IP - Change value to set content manually
$ip_provider="$8"

# Get IP
if [ $ip_provider = "1" ]; then
    record_content=$(dig +short myip.opendns.com @resolver1.opendns.com)
else
    record_content=$(curl -s $ip_provider)
fi
# Determine if IP is IPv6 or IPv4
if [[ $record_content =~ .*:.* ]]
then
    record_type="AAAA"
else
    record_type="A"
fi

# Update Cloudflare
update=$(curl -X PUT "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$zone_record_id" \
     -H "X-Auth-Email: $auth_email" \
     -H "X-Auth-Key: $auth_key" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"$record_type\",\"name\":\"$zone_name\",\"content\":\"$record_content\",\"ttl\":$record_ttl,\"proxied\":$record_proxied}")

# Log
DATE=$(date +%Y-%m-%d:%H:%M:%S)
printf "$DATE - $update\n\n" >> $log