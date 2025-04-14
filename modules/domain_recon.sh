#!/bin/bash

# Get the domain name from the first argument
domain=$1

# Check if the user gave a domain
if [ -z "$domain" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

# Create an output file to store the results
output_file="outputs/domain_basic_$domain.txt"
mkdir -p outputs

echo "[*] Starting basic domain recon on $domain..."
echo "Domain Recon Report for: $domain" > $output_file
echo "------------------------------" >> $output_file

# WHOIS info
echo "[+] WHOIS Info:" >> $output_file
whois $domain | head -n 20 >> $output_file

# IP Address (A record)
echo -e "\n[+] IP Address (A record):" >> $output_file
dig +short $domain >> $output_file

# Nameservers (NS record)
echo -e "\n[+] Nameservers (NS record):" >> $output_file
dig NS $domain +short >> $output_file

# Mail servers (MX record)
echo -e "\n[+] Mail Servers (MX record):" >> $output_file
dig MX $domain +short >> $output_file

echo -e "\n[✓] Recon finished! Results saved in $output_file"
