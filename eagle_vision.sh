#!/bin/bash

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


subnet=$1
domain=$2

if [ -z "$subnet" ] || [ -z "$domain" ]; then
  echo -e "${YELLOW}Usage:${NC} $0 <subnet> <domain>"
  echo -e "Example: $0 192.168.1.0/24 example.com"
  exit 1
fi


mkdir -p outputs


echo -e "${GREEN}[+] Running Host Discovery...${NC}"
bash modules/host_discovery.sh $subnet

echo -e "${GREEN}[+] Running Port Scanning...${NC}"
bash modules/port_scanner.sh

echo -e "${GREEN}[+] Running Service Enumeration...${NC}"
bash modules/service_enum.sh

echo -e "${GREEN}[+] Running Domain Recon...${NC}"
bash modules/domain_recon.sh $domain

echo -e "${YELLOW}[✓] Recon Completed. Results in outputs/${NC}"
