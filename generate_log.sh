#!/bin/bash
IPS=("192.168.1.10" "10.0.0.5" "172.16.0.3" "192.168.1.99" "45.33.32.156" "198.51.100.7")
METHODS=("GET" "GET" "GET" "POST" "POST" "DELETE")
URLS=("/home" "/api/users" "/login" "/api/data" "/missing" "/admin" "/health" "/api/orders")
CODES=(200 200 200 200 404 500 401 403)
for i in $(seq 1 200); do
  IP=${IPS[$RANDOM % ${#IPS[@]}]}
  METHOD=${METHODS[$RANDOM % ${#METHODS[@]}]}
  URL=${URLS[$RANDOM % ${#URLS[@]}]}
  CODE=${CODES[$RANDOM % ${#CODES[@]}]}
  BYTES=$((RANDOM % 5000 + 50))
  echo "$IP - - [25/May/2026:$(printf '%02d' $((RANDOM%24))):$(printf '%02d' $((RANDOM%60))):$(printf '%02d' $((RANDOM%60))) +0000] \"$METHOD $URL HTTP/1.1\" $CODE $BYTES"
done
