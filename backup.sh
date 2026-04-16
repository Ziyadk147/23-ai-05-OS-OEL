#!/bin/bash

# Get script directory (absolute path of where this script lives)
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Define relative project and backup paths
PROJECT="$BASE_DIR/project"
BACKUP="$BASE_DIR/backup/backup_$(date +%F)"

# Create backup directory
mkdir -p "$BACKUP"

count=0

# Copy matching files into backup folder
while IFS= read -r file; do
    cp "$file" "$BACKUP/"
    count=$((count + 1))
done < <(
    find "$PROJECT" -type f \( -name "*.log" -o -name "*.zip" -o -name "*.tmp" \)
)

# Delete .tmp files older than 7 days
find "$PROJECT" -type f -name "*.tmp" -mtime +7 -delete

# Report
echo "Files copied: $count"
echo "done $(date) files copied $count" > "$BACKUP/report.txt"