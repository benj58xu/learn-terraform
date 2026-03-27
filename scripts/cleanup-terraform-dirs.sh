#!/bin/bash

# Script to recursively delete all .terraform directories
# Usage: ./cleanup-terraform-dirs.sh [path]
# If no path is provided, starts from current directory

set -e  # Exit on any error

# Default to current directory if no argument provided
SEARCH_PATH="${1:-.}"

echo "Searching for .terraform directories in: $SEARCH_PATH"
echo "This will permanently delete all found .terraform directories!"
echo ""

# Count directories before deletion
DIR_COUNT=$(find "$SEARCH_PATH" -type d -name ".terraform" | wc -l)
echo "Found $DIR_COUNT .terraform directories"

if [ "$DIR_COUNT" -eq 0 ]; then
    echo "No .terraform directories found. Nothing to clean up."
    exit 0
fi

# Show what will be deleted
echo "Directories to be deleted:"
find "$SEARCH_PATH" -type d -name ".terraform" | sed 's/^/  /'
echo ""

# Ask for confirmation unless NO_CONFIRM is set
if [ -z "$NO_CONFIRM" ]; then
    read -p "Are you sure you want to delete these directories? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 1
    fi
fi

# Delete the directories
echo "Deleting .terraform directories..."
find "$SEARCH_PATH" -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true

echo "Cleanup complete. Deleted $DIR_COUNT .terraform directories."