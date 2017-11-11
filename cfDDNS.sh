#!/bin/bash

#Clears screen
clear

#Variables
auth_email="" #Cloudflare email
auth_key="" #Cloudflare Global API-key
zone_id="" #Cloudflare Zone ID
zone_name="" #CF Zone name (A/AAA/CNAME) example.com/subdomain.example.com
current_content="10.10.10.10" #PrivateIP - change to current IP

script_dir="/opt/cfDDNS" #Directory scripts are stored in
domain_list="$script_dir/list.sh" #Script that contains each domain to update with IP

isInstalled=0

# Checks if cfDDNS is already installed to avoid asking for email and API key
if [ -d "$script_dir" ]; then
        isInstalled=1
fi

addDomain () {
        read -p "Enter your the Zone ID of domain you want to edit a DNS record for: " zone_id
        echo "$zone_id"
        read -p "Enter the DNS record you want to edit (example.com or subdomain.example.com): " zone_name
        echo "$zone_name"
        read -p "Please enter what IP-adress the DNS record currently resolvs to: " current_content
        echo "$current_content"
        record_id=$($script_dir/getID.sh "$zone_id" "$zone_name" "$current_content")
        echo "$record_id"
        echo "\$($script_dir/updateDNS.sh \"$zone_id\" \"$zone_name\" \"$record_id\")" >> $domain_list
}

installedMenu () {
        echo "What do you want to do?"
        echo "[1]- Add a new domain"
        echo "[2]- Remove a domain"
        echo "[3]- Uninstall cfDDNS"
        echo "[4]- Exit cfDDNS config"
        read -p "Selection: " selection
        #echo "$selection"
        case $selection in
                1)
                        addDomain
                ;;
                2)

                ;;
                3)

                ;;
                4)

                ;;
                *)
                        clear
                        WarningColor='\033[0;31m'
                        NoColor='\033[0m'
                        echo -e "${WarningColor}Invalid operation, try again. Only integers between 1 and 4 are valid options.${NoColor}"
                        installedMenu
                ;;
        esac