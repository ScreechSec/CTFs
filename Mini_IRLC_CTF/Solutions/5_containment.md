## Solution

### 1. Endpoint Security Rules
**Objective**: Block malicious processes and sensitive file access.
```yaml
rules:
  - name: Block Netcat Reverse Shells
    description: Detect and block Netcat processes creating reverse shells.
    process:
      executable: /bin/nc
      arguments:
        contains: "-e"
    action: block

  - name: Alert on Sensitive File Access
    description: Detect access to sensitive files like /etc/passwd.
    file_access:
      path: /etc/passwd
      operation: read
    action: alert

  - name: Restrict Unauthorized Shells
    description: Block unauthorized shells running in non-interactive mode.
    process:
      executable: /bin/bash
      arguments:
        contains: "-c"
    action: block
```

---

### 2. Firewall Rules
**Objective**: Block outgoing traffic to the attacker's C2 server and common reverse shell ports.
```bash
# Block outgoing traffic to the attacker's IP
-A OUTPUT -d 203.0.113.5 -j DROP

# Block common ports used for reverse shells
-A OUTPUT -p tcp --dport 4444 -j DROP
-A OUTPUT -p tcp --dport 5555 -j DROP

# Block Netcat communication patterns
-A OUTPUT -p tcp --syn -m conntrack --ctstate NEW --dport 4444 -j DROP
-A OUTPUT -p udp --dport 4444 -j DROP
```

---

### 3. Snort Rules
**Objective**: Detect and alert on malicious traffic and actions.
```plaintext
# Alert on traffic to the attacker's IP
alert tcp any any -> 203.0.113.5 4444 (msg:"C2 Traffic Detected"; sid:1000001; rev:1;)

# Alert on Netcat reverse shell traffic
alert tcp any any -> any 4444 (msg:"Netcat Reverse Shell Detected"; content:"nc -e"; sid:1000002; rev:1;)

# Alert on unauthorized access to sensitive files
alert tcp any any -> any any (msg:"Sensitive File Access Detected"; content:"/etc/passwd"; sid:1000003; rev:1;)
```

---

## Flag
The containment was successful through a combination of endpoint, firewall, and Snort rules.

**Flag**: `flag{attack_contained_successfully}`

---

## Recommendations

### Incident Response
1. Block attacker communication:
   - Use the provided firewall rules to prevent connections to C2 servers.
   - Monitor for future connections using Snort.

2. Harden endpoints:
   - Use the endpoint rules to block malicious processes and unauthorized file access.
   - Disable tools like Netcat on production systems unless explicitly required.

3. Continuous Monitoring:
   - Deploy a SIEM to correlate Snort alerts, endpoint logs, and firewall logs for faster detection.
   - Regularly update IDS/IPS rules with threat intelligence feeds.

---

## Summary
The attack was contained by:
1. Blocking malicious processes and sensitive file access on the endpoint.
2. Preventing outgoing traffic to the attacker's IP and suspicious ports via firewall rules.
3. Detecting and alerting on malicious activity using Snort rules.

The attacker’s activities have been successfully contained.
```
