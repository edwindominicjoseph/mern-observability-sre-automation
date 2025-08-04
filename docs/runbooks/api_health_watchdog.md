# 🛠️ Runbook: API Health Watchdog (User Context Fix)

**Service**: MERN Backend API  
**Component**: Watchdog Cron + PM2  
**Owner**: DevOps/SRE Team  
**Contact**: edj3650@gmail.com  
**Last Updated**: 2025-08-04

---

> ⚠️ **Context**:  
> This Runbook was created as a direct response to an incident I encountered and documented in the corresponding postmortem:  
> [`postmortem_api_downtime_2025-08-04.md`](../postmortems/postmortem_api_downtime_2025-08-04.md).  
> It serves as a troubleshooting guide and fix reference for **user-context mismatches** between PM2-managed processes and cron-executed watchdog scripts.

---

## 📌 Purpose

Ensure the API watchdog script, which monitors `/api/books`, can successfully restart the PM2-managed backend process in case of failure — by running under the **correct user context (`ubuntu`)**.

---

## ⚠️ Problem Summary

PM2 manages the backend (`mern-backend`) under the `ubuntu` user.  
If the watchdog script is executed as `root` (via cron or Ansible), it **cannot see or control** the user-scoped PM2 process. This leads to silent failures where logs indicate detection but no healing occurs.

---

## 🔍 Diagnosis Steps

1. **Check watchdog cron job context**:
   ```bash
   sudo crontab -l
   # If listed here, it runs as root



---
# Inspect watchdog logs:
sudo tail -n 20 /var/log/watchdog.log
May show repeated detection of failure with no restart.

Check PM2 process list under root:
pm2 list
# Likely shows no processes or unrelated ones
Check PM2 process list under ubuntu:
sudo su - ubuntu -c "pm2 list"
Should show mern-backend as online

Test manual restart:
sudo su - ubuntu -c "pm2 stop mern-backend"

# Wait 2 minutes to confirm whether cron restarts it
Resolution Steps
 Fix the cron execution context
Update your Ansible role or manual cron configuration to ensure the script runs as ubuntu, not root.

Option 1: Root crontab with user switch
sudo crontab -e
# Add or modify:
*/2 * * * * su - ubuntu -c '/usr/local/bin/healthwatchdog.sh >> /var/log/watchdog.log 2>&1'


Option 2: User-specific cron
sudo su - ubuntu
crontab -e
# Add:
*/2 * * * * /usr/local/bin/healthwatchdog.sh >> /home/ubuntu/watchdog.log 2>&1


Validation Steps

Stop backend manually:
sudo su - ubuntu -c "pm2 stop mern-backend"


Wait 2 minutes → check logs:
sudo tail -n 20 /var/log/watchdog.log


Confirm PM2 restarted it:
sudo su - ubuntu -c "pm2 status"


Confirm API endpoint is healthy:
curl https://api.edwindominicjoseph.store/api/books
🔄 Rollback Plan
If the cron job breaks:

Disable it temporarily:
sudo crontab -e  # or su to ubuntu and run crontab -e


Restart backend manually:
sudo su - ubuntu -c "pm2 restart mern-backend"

Notes
PM2 maintains isolated process trees per user.

root cannot control ubuntu’s PM2 processes unless explicitly switched via su.

Silent failures are common when commands run in the wrong environment.

Linked Incident
Postmortem: postmortem_api_downtime_2025-08-04.md