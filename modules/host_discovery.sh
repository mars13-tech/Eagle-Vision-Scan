#!/bin/bash

# Get subnet from input
subnet=$1

# Set output path
output_file="outputs/live_hosts.txt"

# Check if subnet is missing
if [ -z "$subnet" ]; then
  echo "[!] Usage: $0 <subnet>"
  echo "    Example: $0 192.168.1.0/24"
  exit 1
fi

# Create output folder if not exists
mkdir -p outputs

# Info message
echo "[*] Scanning for live hosts in $subnet ..."
sleep 1

# Run fping to find alive IPs
fping -a -g $subnet 2>/dev/null > $output_file

# Check if any live hosts found
if [ -s "$output_file" ]; then
  echo "[+] Live hosts found:"
  cat $output_file
else
  echo "[!] No live hosts found in $subnet"
fi
