#!/bin/bash


# Variables
auth_email="mail@example.com" #CF email
auth_key="123456798123abcABC" #CF API key
zone_id="$1" #CF Zone ID
zone_name="$2" # CF Zone name (subdomain: sub.example.com)
current_content="$3" # CF current content of Zone Name to get record identifier from

update=$(curl -s GET "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records?type=A&name=$zone_name&content=$current_content&page=1&per_page=20&order=type&direction=desc&match=all" \
     -H "X-Auth-Email: $auth_email" \
     -H "X-Auth-Key: $auth_key" \
     -H "Content-Type: application/json" | grep -Po '(?<="id":")[^"]*')

# Echo record identifier
echo $update