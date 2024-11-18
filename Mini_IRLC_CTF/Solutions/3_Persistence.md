# Persistence - Solution

## Task
Identify how the attacker maintained persistent access to the system.

---

## Analysis

### 1. Hidden User
The `users.txt` file reveals a suspicious account:
```plaintext
sysd:x:1004:1004:System Daemon:/tmp:/bin/bash

```

### 2. Startup Script
The `startup.sh` file contains a malicious line:
```bash
useradd -M -d /tmp -s /bin/bash sysd 2>/dev/null || echo "User sysd already exists"
```

---

## Flag
The persistence mechanism is the creation and re-addition of the `sysd` user.

**Flag**: `flag{persistent_user_backdoor}`

---

## Recommendations
To mitigate and detect this type of persistence:

### 1. Audit User Accounts
- Regularly review system accounts (`/etc/passwd`) for unauthorized entries.
- Look for suspicious properties, such as:
  - Unusual home directories (e.g., `/tmp`).
  - Executable shells (e.g., `/bin/bash`) for accounts that shouldn’t need them.

### 2. File Integrity Monitoring (FIM)
- Monitor critical files like `startup.sh` for unauthorized modifications.
- Implement tools like **Tripwire** or **osquery** to detect changes.

### 3. Restrict Access
- Limit access to critical files like startup scripts and `/etc/passwd` to administrators only.
- Use strict access controls to prevent non-root users from executing `useradd`.

### 4. Centralized Logging
- Configure a centralized logging system (e.g., **SIEM**) to detect log tampering or unusual user activity.
- Track reboots and unexpected changes to user accounts.

### Incident Response
If unauthorized accounts or script modifications are detected:

- Remove the malicious account and script lines.
- Investigate how the attacker gained `root` access to prevent recurrence.

---

### Summary
The attacker maintained persistence by:

- Adding a hidden user (`sysd`) with `/bin/bash` access.
- Modifying the `startup.sh` script to re-add the `sysd` user on system reboots.
