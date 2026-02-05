# \[Fail2ban\] IP

This *fail2ban_ip.sh* file is a script that displays the banned IP addresses of your Fail2ban jails in the following format:

**jail_name** `(currently_banned/total_banned)`  
`   xxx.xxx.xxx.xxx   country   net_name`  
`   xxx.xxx.xxx.xxx   country   net_name`  
`   xxx.xxx.xxx.xxx   country   net_name`  
`   ...`

---

## Usage:

Download the *fail2ban_ip.sh* file or create a new one and copy/paste its contents.

Make it executable:

    chmod u+x fail2ban_ip.sh

Run the script to display IP addresses without country or net_name (faster):

    ./fail2ban_ip.sh

Run the script with the *-v* argument to display IP addresses with country and net_name (slower, requires the *whois* package):

    ./fail2ban_ip.sh -v
