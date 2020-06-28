#!/bin/sh

# Internal IP
IP=$(hostname -I | awk {'print $1}')

PUBLIC_IP=$(curl -4 ifconfig.me)

if [[ "$PUBLIC_IP" = ";; connection timed out; no servers could be reached" ]]; then
    PUBLIC_IP="Not Available"
elif [[ "$PUBLIC_IP" = "" ]]; then
    PUBLIC_IP="No external access"
else
    PUBLIC_IP=$(curl -4 ifconfig.me)
fi

echo -n "🏠 #[fg=black]$IP | 📡 $PUBLIC_IP"
