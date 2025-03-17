#!/bin/bash

# System Health Monitoring Script

HOSTNAME=$(hostname)
CURRENT_DATE=$(date)
USER=$(whoami)

echo "==========================="
echo " System Health Report "
echo "==========================="
echo "Hostname: $HOSTNAME"
echo "Date & Time: $CURRENT_DATE"
echo "Current User: $USER"
echo "---------------------------"

echo "What do you want to check?"
echo "1. CPU Usage"
echo "2. Memory Usage"
echo "3. Disk Usage"
echo "4. All"

read -p "Enter choice [1-4]: " choice

case $choice in
  1) 
    CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    CPU_LOAD_INT=${CPU_LOAD%.*}
    if [ "$CPU_LOAD_INT" -gt 80 ]; then
      echo "⚠️ Warning: High CPU usage detected: ${CPU_LOAD}%"
    else
      echo "✅ CPU usage is normal: ${CPU_LOAD}%"
    fi
    ;;
  2) 
    echo "Memory Usage:"
    free -m | awk 'NR==2{printf "Total: %sMB, Used: %sMB, Free: %sMB\n", $2, $3, $4}'
    ;;
  3)
    echo "Disk Usage:"
    df -h
    ;;
  4)
    # CPU
    CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    echo "CPU Usage: ${CPU_LOAD}%"
    if [ "${CPU_LOAD%.*}" -gt 80 ]; then
      echo "⚠️ Warning: High CPU usage detected!"
    fi

    # Memory
    echo "Memory Usage:"
    free -m | awk 'NR==2{printf "Total: %sMB, Used: %sMB, Free: %sMB\n", $2, $3, $4}'

    # Disk
    echo "Disk Usage:"
    df -h
    ;;
  *) 
    echo "Invalid choice!" 
    ;;
esac

echo "==========================="
