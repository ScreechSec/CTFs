# Initial Access - Solution

## Task
Identify how the attacker gained access to the system.

## Analysis
The malicious actor used SQL injection to gain access. The logs show the following suspicious requests from the IP `192.168.1.100`:

1. **SQL Injection to Bypass Filters**:
- The payload `id=1 OR 1=1--` is a common SQL injection technique to bypass authentication or other conditions.

2. **SQL Injection to Extract Data**:
- This `UNION` query attempts to extract sensitive information (`username` and `password`) from the database.

## Flag
The malicious request used for initial access is:

**Flag**: `flag{SQL_injection_initial_access}`

---
## Summary
The attacker used an SQL injection attack to:
1. Identify vulnerabilities in the application.
2. Extract sensitive data by leveraging improperly sanitized input fields.

To mitigate this:
- Sanitize and validate user input.
- Use parameterized queries.
- Implement a Web Application Firewall (WAF) to detect and block SQL injection attempts.

