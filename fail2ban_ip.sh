#!/bin/bash

#######################################################################################################
# FILE          : fail2ban_ip.sh
# DESCRIPTION   : Display the banned IP addresses of your Fail2ban jails in a more user-friendly format
# AUTHOR        : HellPC
# DATE          : 2026.02.11
# README        : https://github.com/He11PC/fail2ban-ip#readme
# LICENSE       : MIT
#######################################################################################################


VERBOSE=false
if [ "$1" = "-v" ]; then
    VERBOSE=true
fi

bold=$(tput bold)
normal=$(tput sgr0)

JAIL_LIST=$(sudo fail2ban-client status | grep 'Jail list:' | sed 's/.*://;s/,//g')

echo
for jail in $JAIL_LIST; do
    JAIL_DATA=$(sudo fail2ban-client status "$jail")
    JAIL_CURRENT=$(echo "$JAIL_DATA" | grep 'Currently banned:' | awk '{print $NF}')
    JAIL_TOTAL=$(echo "$JAIL_DATA" | grep 'Total banned:' | awk '{print $NF}')
    JAIL_IP_LIST=$(echo "$JAIL_DATA" | grep 'Banned IP list:' | sed 's/.*://g')

    echo "${bold}$jail${normal} (${JAIL_CURRENT:-0}/${JAIL_TOTAL:-0})"
    if [[ -n "$JAIL_IP_LIST" ]] then
        for ip in $JAIL_IP_LIST; do
            if [ "$VERBOSE" = true ]; then
                IP_DETAILS=$(whois $ip)
                IP_COUNTRY=$(echo "$IP_DETAILS" | grep 'country:' -i -m 1 | cut -d ':' -f 2 | xargs)
                IP_NETNAME=$(echo "$IP_DETAILS" | grep 'netname:' -i -m 1 | cut -d ':' -f 2 | xargs)
                echo -e "   $ip\t$IP_COUNTRY\t$IP_NETNAME"
            else
                echo "  $ip"
            fi
        done | column -s $'\t' -t
    fi
    echo
done
