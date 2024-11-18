## Solution

### 1. Remove Malicious User
The attacker’s hidden user `sysd` was identified in the `users.txt` file:
```plaintext
sysd:x:1004:1004:System Daemon:/tmp:/bin/bash
```
To remove the user:
```bash
userdel sysd
```

---

### 2. Clean Up Startup Script
The attacker modified `startup.sh` to re-add the malicious user `sysd` on reboot:
```bash
useradd -M -d /tmp -s /bin/bash sysd 2>/dev/null || echo "User sysd already exists"
```
To eradicate this backdoor:
1. Open `startup.sh` in a text editor.
2. Remove the malicious line:
   ```bash
   useradd -M -d /tmp -s /bin/bash sysd 2>/dev/null || echo "User sysd already exists"
   ```

---

### 3. Delete Suspicious Files
The `file_list.txt` file reveals several suspicious files:
```plaintext
/tmp/.hidden_malware
/var/tmp/system_backup.sh
/var/tmp/.attacker_script
```
These files are likely malicious. To delete them:
```bash
rm -f /tmp/.hidden_malware
rm -f /var/tmp/system_backup.sh
rm -f /var/tmp/.attacker_script
```

---

## Verification
To ensure eradication is complete:
1. **Check Users**:
   - Verify the `sysd` user has been removed:
     ```bash
     cat /etc/passwd | grep sysd
     ```
     Output should be empty.

2. **Inspect Startup Script**:
   - Ensure no backdoors remain:
     ```bash
     cat /etc/init.d/startup.sh
     ```
     Confirm the malicious line is removed.

3. **Scan for Leftover Files**:
   - Use `find` to locate any additional hidden files:
     ```bash
     find /tmp /var/tmp -name ".*" -o -name "*.sh"
     ```

---

## Flag
The eradication was successful by removing the attacker’s artifacts.

**Flag**: `flag{eradication_complete}`

---

## Recommendations

### 1. Harden User Management
- Regularly audit user accounts for unauthorized additions.
- Use tools like `osquery` or `AIDE` to monitor user changes.

### 2. Monitor Critical Scripts
- Implement file integrity monitoring (FIM) tools to detect modifications to critical files like `startup.sh`.
- Restrict write permissions on critical directories.

### 3. Temporary Directory Security
- Configure `/tmp` and `/var/tmp` with the `noexec` option in `/etc/fstab` to prevent execution of malicious scripts.

### 4. Centralized Logging
- Use a SIEM to monitor suspicious file creations, user account changes, and script modifications.

---

## Summary
The attacker’s activity was eradicated by:
1. Removing the malicious user `sysd`.
2. Cleaning up the backdoor in the `startup.sh` script.
3. Deleting all suspicious files in `/tmp` and `/var/tmp`.

With these steps, the system has been restored to a secure state.
```
