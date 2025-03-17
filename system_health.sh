#!/bin/bash

# ========================================
# Advanced System Health Monitor Script
# ========================================

HOSTNAME=$(hostname)
CURRENT_DATE=$(date)
USER=$(whoami)

# ======= System Information =======
echo "======================================"
echo "       System Health Report        "
echo "======================================"
echo "Hostname    : $HOSTNAME"
echo "Date & Time : $CURRENT_DATE"
echo "User        : $USER"
echo "--------------------------------------"

# ======= Functions =======

get_cpu_usage() {
    echo "CPU Usage:"
    CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    CPU_LOAD_INT=${CPU_LOAD%.*}
    echo "CPU Load: ${CPU_LOAD}%"
    if [ "$CPU_LOAD_INT" -gt 80 ]; then
        echo "arning: High CPU usage detected!"
    else
        echo "CPU usage is normal."
    fi
    echo "--------------------------------------"
}

get_memory_usage() {
    echo "Memory Usage:"
    free -m | awk 'NR==2{printf "Total: %sMB, Used: %sMB, Free: %sMB\n", $2, $3, $4}'
    echo "--------------------------------------"
}

get_disk_usage() {
    echo "Disk Usage:"
    df -h | awk '{print $1, $2, $3, $4, $5, $6}'
    echo "--------------------------------------"
}

get_network_info() {
    echo "Network Information (IP Address):"
    ip a | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1
    echo "--------------------------------------"
}

# ======= Main Menu =======

echo "Choose what you want to check:"
echo "1. CPU Usage"
echo "2. Memory Usage"
echo "3. Disk Usage"
echo "4. Network Info"
echo "5. All"

read -p "Enter choice [1-5]: " choice
echo "--------------------------------------"

case $choice in
  1) get_cpu_usage ;;
  2) get_memory_usage ;;
  3) get_disk_usage ;;
  4) get_network_info ;;
  5)
    get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_network_info
    ;;
  *) echo "❌ Invalid choice!" ;;
esac

echo "======================================"
echo "System Health Check Complete."
echo "======================================"

