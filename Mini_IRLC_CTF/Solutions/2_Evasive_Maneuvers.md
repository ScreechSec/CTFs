# Evasive Maneuvers - Solution

## Task
Identify how the attacker attempted to hide their actions after gaining initial access.

## Analysis
1. **Initial Access**:
   - The attacker originally exploited the web server using SQL injection (`192.168.1.100`), as identified in the **Initial Access** challenge.

2. **Evasive Actions**:
   - Upon accessing the system, the attacker deleted logs to cover their tracks. This is evident from the gap in timestamps:
     - The last log before the gap: `10:11:05`
     - The first log after the gap: `10:15:17`
     - Duration of missing logs: ~4 minutes.

   - During this time, the attacker likely used tools or commands to erase evidence. The suspicious IP `192.168.1.100` reappears after the gap.

3. **Privilege Escalation**:
   - At `10:15:18`, the attacker used `su` to escalate privileges to `root`, as shown in:
     ```
     Nov 18 10:15:18 server1 su[98765]: + /dev/tty: root by admin
     ```

## Flag
The time gap and privilege escalation indicate the attacker’s attempt to hide their actions.

**Flag**: `flag{evasive_logs_deleted}`

---
## Summary
The attacker’s evasive maneuvers included:
1. Deleting logs to hide malicious activities between `10:11:05` and `10:15:17`.
2. Reconnecting via SSH with the `root` user and escalating privileges using `su`.

To mitigate this:
- Enable audit logging for critical actions (e.g., file deletions).
- Use a centralized logging system that attackers cannot easily manipulate.
- Monitor for unusual gaps in logs or connections from suspicious IPs like `192.168.1.100`.
