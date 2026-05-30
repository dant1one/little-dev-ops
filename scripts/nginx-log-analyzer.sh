#!/bin/bash

# This script analyzes an Nginx access log file to extract insights such as the most frequent IP addresses, requested paths, response status codes, and user agents. It uses the following commands:
# - awk: to process and extract specific fields from the log file
# - sort: to sort the extracted data
# - uniq: to count unique occurrences
# - head: to display the top results
# To run this script, save it to a file (e.g., nginx-log-analyzer.sh), give it execute permissions (chmod +x nginx-log-analyzer.sh), and then execute it (./nginx-log-analyzer.sh).


COUNT=5

LOG_FILE="../training-files/nginx-access.log"

printf "\n Top %d IP addresses with the most requests: \n" $COUNT

awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -n $COUNT

printf "\n Top %d most requested paths: \n" $COUNT

awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -nr | head -n $COUNT

printf "\n Top %d response status codes: \n" $COUNT

awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n "$COUNT"

printf "\n Top %d user agents: \n" $COUNT
awk -F'"' '{print $6}' $LOG_FILE | sort | uniq -c | sort -nr | head -n $COUNT