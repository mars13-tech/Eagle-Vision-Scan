#!/bin/bash

# Input list of live hosts
input_file="outputs/live_hosts.txt"
output_file="outputs/service_enum_results.txt"

# Check if live host file exists
if [ ! -f "$input_file" ]; then
  echo "[!] No live hosts found. Run host_discovery.sh first."
  exit 1
fi

# Clear or create output file
> $output_file

echo "[*] Starting service enumeration on live hosts..."
sleep 1

# Loop through each live host
while read ip; do
  echo "[+] Enumerating services on $ip..."
  echo "Service scan results for $ip:" >> $output_file
  nmap -sV -T4 $ip >> $output_file
  echo "--------------------------" >> $output_file
done < $input_file

echo "[✓] Service enumeration complete. Results saved to $output_file"
