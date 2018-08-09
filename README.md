# CFDDNS
A simple and easy-to-use Dynamic DNS tool to automatically update your DNS records at Cloudflare via bash.
This is a Work-In-Progress (WIP) but it does work. There might however be some bugs and not all functions are complete.
# Installation
Run the following script and enter the Cloudflare info needed to update your DNS settings via the Cloudflare API.
`wget https://raw.githubusercontent.com/ludwigjohnson/CFDDNS/master/cfDDNS.sh -O cfDDNS.sh && bash cfDDNS.sh install`
The file is the main install tool but it will download the three files available in the opt/cfDDNS folder as well.
