# 🧾 Postmortem: MERN Backend API Watchdog Failure

**Date**: 2025-08-04  
**Service Affected**: `https://api.edwindominicjoseph.store/api/books`  
**Reported By**: Watchdog cron job  
**Impact**:  
The backend became unresponsive. The watchdog detected the issue and logged it correctly, but failed to restart the backend due to a user mismatch between the cron job (running as `root`) and the actual PM2-managed process (running under `ubuntu`).

---

## ⏱️ Timeline

| Time (UTC) | Event                                                                 |
|------------|------------------------------------------------------------------------|
| 09:12      | Watchdog detects API is unresponsive                                  |
| 09:12      | Cron job triggers `pm2 restart` under root (appears successful, but no effect) |
| 09:15      | Watchdog logs show detection of failure but no actual restart         |
| 09:20      | Manual inspection confirms `mern-backend` is running under `ubuntu`'s PM2 session |
| 09:22      | Manual stop of backend confirms it does not auto-recover              |
| 09:25      | Root cause confirmed: script executed by root user, unable to control `ubuntu`'s PM2 |
| 09:28      | Ansible role updated to execute watchdog as `ubuntu`                  |
| 09:30      | Cron-based restart confirmed working — backend restarts auto-heal     |

---

## 🔍 Root Cause

The watchdog script was executed via cron under the `root` user, but the PM2 process managing `mern-backend` belonged to the `ubuntu` user. As a result, commands like `pm2 restart` from root had no effect, even though logs showed failure detection.

---

## 🛠️ Resolution

- Updated the Ansible watchdog role to execute the script under the correct user (`ubuntu`) instead of `root`.
- No changes were needed to the script itself — only the cron context was corrected.
- After the fix, stopping the backend manually triggered an auto-restart via the healing cron job after 2 minutes.

---

## 📚 Lessons Learned

- PM2 maintains separate process lists per user — even if globally installed.
- Scripts running under `root` cannot manage user-specific PM2 sessions.
- Automation must match the ownership context of the services it controls.

---

## 🚧 Preventative Actions

- Always align the **cron user context** with the **PM2 process owner**.
- Include checks in watchdog scripts to validate whether `pm2 restart` was effective.
- Ensure Ansible enforces the correct user in both **process management** and **script execution**.

---

## 👤 Incident Owner

**Name**: Edwin Joseph  
**Email**: edj3650@gmail.com

---
