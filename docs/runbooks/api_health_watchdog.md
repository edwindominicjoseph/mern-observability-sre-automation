# 🛠️ Runbook: API Health Watchdog

**Service**: MERN Backend API  
**Owner**: DevOps/SRE Team  
**Contact**: edj3650@gmail.com  
**Last Updated**: 2025-08-04

---

## 📌 Purpose

To monitor the health of the `/api/books` endpoint and automatically restart the backend process using `pm2` if the API becomes unresponsive.

---

## 🔍 Diagnosis Steps

1. **Check watchdog log for errors**:
   ```bash
   sudo tail -n 20 /var/log/watchdog.log

---


Test API manually:
curl -v https://api.edwindominicjoseph.store/api/books


Check if pm2 is in root or cron PATH:
which pm2

Check pm2 process under the correct user (ubuntu):
sudo su - ubuntu -c "pm2 status"

Remediation
Update watchdog script to run PM2 as ubuntu:
sudo su - ubuntu -c "/usr/bin/pm2 restart mern-backend"



Update Ansible role:

Ensure script is at /usr/local/bin/healthwatchdog.sh
Cron executes as root but switches user context using sudo su - ubuntu -c

Re-run manually for validation:
sudo bash /usr/local/bin/healthwatchdog.sh


Validation
Check API response:
curl https://api.edwindominicjoseph.store/api/books
Expected: JSON response with field "book"

Check pm2 status:
sudo su - ubuntu -c "pm2 status"
Expected: mern-backend should be online

Check logs:
sudo tail /var/log/watchdog.log
Expected: Entry confirming successful restart with timestamp

Rollback
Disable watchdog from cron:

sudo crontab -e
# Comment out the watchdog line
Restart backend manually if needed:
sudo su - ubuntu -c "pm2 restart mern-backend"
