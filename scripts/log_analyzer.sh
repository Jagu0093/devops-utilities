#!/bin/bash
# ─────────────────────────────────────────────
# log_analyzer.sh
# Description : Analyze nginx-style access logs
# Usage       : ./log_analyzer.sh <logfile> [top_n]
# Example     : ./log_analyzer.sh access.log 10
# Author      : DevOps Practice
# License     : MIT
# ─────────────────────────────────────────────
set -euo pipefail

LOG_FILE="${1:-}"
TOP_N="${2:-5}"

if [[ -z "$LOG_FILE" ]]; then
  echo "Usage: $0 <logfile> [top_n]"
  exit 1
fi

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Error: file not found: $LOG_FILE"
  exit 1
fi

TOTAL=$(wc -l < "$LOG_FILE")
ERRORS=$(awk '$9 >= 400' "$LOG_FILE" | wc -l)
OK=$(awk '$9 == 200' "$LOG_FILE" | wc -l)

if [[ $TOTAL -eq 0 ]]; then
  echo "Log file is empty."
  exit 0
fi

TOP_IPS=$(awk '{print $1}' "$LOG_FILE" \
  | sort | uniq -c | sort -rn | head -"$TOP_N")

TOP_URLS=$(awk '{print $7}' "$LOG_FILE" \
  | sort | uniq -c | sort -rn | head -"$TOP_N")

STATUS_COUNTS=$(awk '{print $9}' "$LOG_FILE" \
  | sort | uniq -c | sort -rn)

ERROR_RATE=$(awk "BEGIN {printf \"%.1f\", ($ERRORS/$TOTAL)*100}")

echo "================================"
echo " Log Analysis Report"
echo " File: $LOG_FILE"
echo "================================"
echo ""
echo "Total requests  : $TOTAL"
echo "OK (200)        : $OK"
echo "Errors (4xx/5xx): $ERRORS"
echo "Error rate      : ${ERROR_RATE}%"
echo ""
echo "--- Status code breakdown ---"
echo "$STATUS_COUNTS"
echo ""
echo "--- Top $TOP_N IPs ---"
echo "$TOP_IPS"
echo ""
echo "--- Top $TOP_N URLs ---"
echo "$TOP_URLS"
echo ""
