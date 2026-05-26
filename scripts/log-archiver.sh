#!/bin/bash

#This script is designed to archive log files in a specified directory. It compresses the log files DIRECTORY
#into tar.gz format and saves them it in an archive directory with a timestamp. The main commands used in this script are:
#- find: to locate log files in the specified directory
#- tar: to create compressed archive files
#- mkdir: to create the archive directory if it doesn't exist
#To run this script, save it to a file (e.g., log-archiver.sh), give it execute permissions (chmod +x log-archiver.sh),
#and then execute it (./log-archiver.sh).

set -euo pipefail

LOG_DIR="/var/log"
ARCHIVE_DIR="$HOME/alogs"
LOG_TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p "$ARCHIVE_DIR"

ARCHIVE_FILE="$ARCHIVE_DIR/logs_$LOG_TIMESTAMP.tar.gz"

echo "Creating archive: $ARCHIVE_FILE"

# Create one archive for all .log files
find "$LOG_DIR" -type f -name "*.log" -print0 | \
tar --null -czf "$ARCHIVE_FILE" --files-from=-

echo "Archive created successfully: $ARCHIVE_FILE"