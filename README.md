# CFDDNS
A simple and easy-to-use Dynamic DNS tool to automatically update your DNS records at Cloudflare via bash.
This is a Work-In-Progress (WIP) but it does work. There might however be some bugs and not all functions are complete.
# Installation
Run the following script and enter the Cloudflare info needed to update your DNS settings via the Cloudflare API.
`wget https://raw.githubusercontent.com/ludwigjohnson/CFDDNS/master/cfDDNS.sh -O cfDDNS.sh && bash cfDDNS.sh install`
The file is the main install tool but it will download the three files available in the opt/cfDDNS folder as well.

To add more domains/subdomains, simply run the `bash cfDDNS.sh install` command again.

### Alternatively
Create the directories `bin/cfDDNS` inside your $HOME and download the three files inside `opt/cfDDNS` and change the mode of the files to be runnable by the user that will update the Cloudflare IP. Download the cfDDNS.sh file to any folder and run `cfDDNS.sh install` to add a domain (run this again for every domain you want to add). Lastly, open crontab for the user of your choice and set the file `$HOME/bin/cfDDNS/list.sh` to be run at a specific interval (default value for default install method is every five minutes).
