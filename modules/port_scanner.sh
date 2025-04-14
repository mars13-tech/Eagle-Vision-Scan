#!/bin/bash

# Input file from previous module
input_file="outputs/live_hosts.txt"
output_file="outputs/port_scan_results.txt"

# Check if live hosts file exists
if [ ! -f "$input_file" ]; then
  echo "[!] No live hosts found. Run host_discovery.sh first."
  exit 1
fi

# Clear or create output file
> $output_file

echo "[*] Starting port scan on live hosts..."
sleep 1

# Loop through each live host and scan ports
while read ip; do
  echo "[+] Scanning $ip..."
  echo "Scan results for $ip:" >> $output_file
  nmap -p- --min-rate=1000 -T4 $ip >> $output_file
  echo "--------------------------" >> $output_file
done < $input_file

echo "[✓] Port scanning complete. Results saved to $output_file"

