#!/bin/bash

# Colors for output
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"

echo -e "${GREEN}Starting system maintenance script...${NC}"

# Function to install necessary software
install_software() {
    echo -e "${YELLOW}Installing essential software...${NC}"
    sudo apt update -y
    sudo apt install -y curl wget git vim net-tools htop unzip
    echo -e "${GREEN}Software installation complete!${NC}"
}

# Function to update the system
update_system() {
    echo -e "${YELLOW}Updating system packages...${NC}"
    sudo apt update -y && sudo apt upgrade -y
    echo -e "${GREEN}System update complete!${NC}"
}

# Function to check system health
system_health_check() {
    echo -e "${YELLOW}Performing system health check...${NC}"

    echo -e "\n${GREEN}CPU Usage:${NC}"
    top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4 "% CPU Usage"}'

    echo -e "\n${GREEN}Memory Usage:${NC}"
    free -h

    echo -e "\n${GREEN}Disk Usage:${NC}"
    df -h /

    echo -e "\n${GREEN}Network Connectivity Test:${NC}"
    ping -c 4 8.8.8.8 &> /dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Internet is working.${NC}"
    else
        echo -e "${RED}No internet connection detected.${NC}"
    fi

    echo -e "${GREEN}System health check complete!${NC}"
}

# Execute functions
install_software
update_system
system_health_check

echo -e "${GREEN}System maintenance tasks completed!${NC}"
