#!/bin/bash

#Clears screen
clear

instruction="$1"
if [ "$instruction" = "install" ]; then

        #Variables
        auth_email="" #Cloudflare email
        auth_api="" #Cloudflare Global API-key
        zone_id="" #Cloudflare Zone ID
        zone_name="" #CF Zone name (A/AAA) example.com/subdomain.example.com
        current_content="10.10.10.10" #PrivateIP - change to current IP
        record_ttl="1" #TTL (time to live) in seconds, 1 = automatic (if proxied == 1, this will always be automatic)
        record_type="A"
        ip_provider="1"


        script_dir="$HOME/bin/cfDDNS" #Directory scripts are stored in
        domain_list="$script_dir/list.sh" #Script that contains each domain to update with IP

        isInstalled=0

        # Checks if cfDDNS is already installed to avoid asking for email and API key
        if [ -d "$script_dir" ]; then
                isInstalled=1
        else
                echo "Downloading files..."
                mkdir -p "$script_dir"
                curl https://raw.githubusercontent.com/ludwigjohnson/CFDDNS/master/opt/cfDDNS/getID.sh > "$script_dir/getID.sh"
                curl https://raw.githubusercontent.com/ludwigjohnson/CFDDNS/master/opt/cfDDNS/getID.sh > "$domain_list"
                curl https://raw.githubusercontent.com/ludwigjohnson/CFDDNS/master/opt/cfDDNS/getID.sh > "$script_dir/updateDNS.sh"
                chmod 771 "$script_dir/getID.sh"
                chmod 771 "$domain_list"
                chmod 771 "$script_dir/updateDNS.sh"
                echo "Download complete."

                #TODO add crontab job and check how often the user wants to run it
        fi

        # EMAIL, APIKEY, ZONEID (root domain zone ID), ZONENAME (domain/subdomain), RECORDID (automatically gotten via API), RECORDTYPE (A, AAAA), RECORDTTL (seconds), PROXIED, IPPROVIDERID(get list of ip providers)

        #recordType, ipProvider
        addDomain () {
                read -p "Enter the email registered to your Cloudflare account: " auth_email
                echo "$auth_email"
                read -p "Enter the Global API Key found under 'My Profile' on the Cloudflare website: " auth_api
                echo "$auth_api"
                read -p "Enter your the Zone ID of domain you want to edit a DNS record for: " zone_id
                echo "$zone_id"
                read -p "Enter the DNS record you want to edit (example.com or subdomain.example.com): " zone_name
                echo "$zone_name"
                read -p "Enter what IP-adress the DNS record currently resolvs to: " current_content
                echo "$current_content"
                record_id=$($script_dir/getID.sh "$zone_id" "$zone_name" "$current_content" "$auth_email" "$auth_api")
                echo "DNS record ID: $record_id"
                if [ "$record_id" = "" ]; then
                        read -p "An error occurred, please check that your values are correct and try again."
                        addDomain
                else
                        read -p "Proxy traffic through Cloudflare (y/n): " proxied
                        echo "$proxied"
                        if [ "$proxied" = "n" ]; then
                                read -p "Enter TTL (Time To Live) in seconds: " record_ttl
                                echo "$record_ttl"
                        fi

                        echo "Choose an IP provider"
                        echo "[1]- OpenDNS (recommended/default - via DNS protocol)"
                        echo "[2]- ipinfo.io/ip (via cURL)"
                        echo "[3]- ifconfig.co (via cURL)"
                        echo "[4]- Custom (via cURL)"
                        read -p "Selection: " selection
                        case $selection in
                                1)
                                        ip_provider="1"
                                ;;
                                2)
                                        ip_provider="ipinfo.io/ip"
                                ;;
                                3)
                                        ip_provider="ifconfig.co"
                                ;;
                                4)
                                        read -p "Enter the domain to fetch IP information from via cURL: " ip_provider
                                        echo $ip_provider
                                ;;
                                *)
                                        ip_provider="1"
                                ;;
                        esac

                        echo "\$($script_dir/updateDNS.sh \"$auth_email\" \"$auth_api\" \"$zone_id\" \"$zone_name\" \"$record_id\" \"$record_ttl\" \"$proxied\" \"$ip_provider\")" >> $domain_list
                fi
                
        }

        installedMenu () {
                echo "What do you want to do?"
                echo "[1]- Add a new domain"
                echo "[2]- Remove a domain"
                echo "[3]- Uninstall cfDDNS" #TODO Change to enable/disable since it isn't really installed more than a couple of scripts and a crontab entry
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
        }
        installedMenu
elif [ "$instruction" = "update" ]; then
        #todo, run the command that crontab is going to use
elif [ "$instruction" = "help" ]; then
        echo "This should contain help information in the future. I will hopefully not forget, otherwise contact me on github and I'll add it."
else
        read -p "An error occurred, unknown command $instruction. Please use help command or contact me at github.com/ludwigjohnson/CFDDNS"
fi