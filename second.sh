#!/bin/bash
echo "System Information Script"
echo "-------------------------"
echo "Hostname: $(hostname)"
echo "Operating System: $(uname -o)"
echo "Kernel Version: $(uname -r)"
echo "Uptime: $(uptime -p)"
