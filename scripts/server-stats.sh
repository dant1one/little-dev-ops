#!/bin/bash
: '
Here u can see the system stats like CPU, Memory, Swap, Disk usage and top processes by CPU and Memory usage.
This script is useful for monitoring the server performance and identifying any potential issues.
main commands used in this script are:
- top: to get the CPU usage
- free: to get the Memory and Swap usage
- df: to get the Disk usage
- ps: to get the top processes by CPU and Memory usage
- awk: to format the output of the commands
To run this script, save it to a file (e.g., server-stats.sh), give it execute permissions (chmod +x server-stats.sh), and then execute it (./server-stats.sh).
'

clear

echo "=============================="
echo "      SYSTEM MONITOR"
echo "=============================="
echo

# CPU
echo "CPU Usage:"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

printf "Used: %.2f%%\n" "$cpu_usage"

echo
echo "------------------------------"

# Memory/Swap
echo "Memory/Swap Usage:"

free -h | awk '
/Mem:/ {
printf "\n"
printf "Memory Usage:\n"
total=$2
used=$3
free=$4
percent=($3/$2)*100

printf "Total: %s\n", total
printf "Used : %s\n", used
printf "Free : %s\n", free
printf "Usage: %.2f%%\n\n", percent
}

/Swap:/ {
printf "Swap Usage:\n"
swap_total=$2
swap_used=$3
swap_free=$4

if ($2 == 0)
    swap_percent=0
else
    swap_percent=($3/$2)*100

printf "Total: %s\n", swap_total
printf "Used : %s\n", swap_used
printf "Free : %s\n", swap_free
printf "Usage: %.2f%%\n", swap_percent
}'

echo
echo "------------------------------"

# Disk
echo "Disk Usage (/):"

df -h / | awk '
NR==2{
print "Total:", $2
print "Used :", $3
print "Free :", $4
print "Usage:", $5
}'

echo
echo "------------------------------"

# Top CPU processes
echo "Top 5 Processes by CPU:"
ps aux --sort=-%cpu | head -6

echo
echo "------------------------------"

# Top Memory processes
echo "Top 5 Processes by Memory:"
ps aux --sort=-%mem | head -6