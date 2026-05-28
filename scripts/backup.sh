#!/bin/bash
# ─────────────────────────────────────────
# backup.sh
# Description : Backup a directory with timestamp
# Usage       : ./backup.sh <source_dir> <backup_dir>
# Example     : ./backup.sh ~/projects ~/backups
# ─────────────────────────────────────────
set -euo pipefail

SOURCE="${1:-}"
DEST="${2:-}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [[ -z "$SOURCE" || -z "$DEST" ]]; then
  echo "Usage: $0 <source> <destination>"
  exit 1
fi

if [[ ! -d "$SOURCE" ]]; then
  echo "Error: source directory not found: $SOURCE"
  exit 1
fi

mkdir -p "$DEST"
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"

tar -czf "${DEST}/${BACKUP_NAME}" "$SOURCE"
echo "Backup created: ${DEST}/${BACKUP_NAME}"
echo "Size: $(du -sh "${DEST}/${BACKUP_NAME}" | cut -f1)"
