#!/bin/bash

LOG_DIR="./sample-logs"

# Ensure directory exists
mkdir -p "$LOG_DIR"

# Apache sample log
cat > "$LOG_DIR/apache_logs.log" <<EOL
192.0.2.1 - - [02/Sep/2025:12:00:00 +0000] "GET /index.html HTTP/1.1" 200 1024 "-" "Mozilla/5.0"
203.0.113.5 - - [02/Sep/2025:12:01:12 +0000] "POST /login HTTP/1.1" 401 512 "-" "Mozilla/5.0"
198.51.100.7 - - [02/Sep/2025:12:02:45 +0000] "GET /admin HTTP/1.1" 403 245 "-" "Mozilla/5.0"
EOL

# Syslog sample log
cat > "$LOG_DIR/syslog.log" <<EOL
Sep  2 12:00:01 server1 sshd[1123]: Failed password for invalid user root from 192.0.2.44 port 54321 ssh2
Sep  2 12:01:22 server1 sshd[1123]: Accepted password for admin from 203.0.113.9 port 51234 ssh2
Sep  2 12:02:33 server1 systemd[1]: Started Apache HTTP Server.
EOL

# Security events log
cat > "$LOG_DIR/security_events.log" <<EOL
2025-09-02 12:00:55 Suricata: ET SCAN Nmap Scan Detected SRC=192.0.2.55 DST=10.0.0.5
2025-09-02 12:02:10 Firewall: Blocked incoming connection from 203.0.113.99 on port 8080
2025-09-02 12:03:15 IDS: Brute-force attack detected from 198.51.100.222 to service ssh
EOL

echo "✅ Test data written to $LOG_DIR"
