

### 🧾 `docs/postmortems/postmortem_api_downtime_2025-08-04.md`

```markdown
# 🧾 Postmortem: MERN Backend API Watchdog Failure

**Date**: 2025-08-04  
**Service Affected**: `https://api.edwindominicjoseph.store/api/books`  
**Reported By**: Watchdog cron job  
**Impact**:  
API became unresponsive. The watchdog detected the failure but the restart command failed silently due to incorrect user context.

---

## ⏱️ Timeline

| Time (UTC) | Event                                                                 |
|------------|------------------------------------------------------------------------|
| 09:12      | Watchdog detects API is unresponsive                                  |
| 09:12      | Cron attempts `pm2 restart` under root (fails silently)               |
| 09:15      | Manual testing reveals PM2 not installed globally for root            |
| 09:20      | Root cause confirmed: PM2 only installed for `ubuntu` user            |
| 09:25      | Watchdog script updated to use `sudo su - ubuntu -c` for PM2 commands |
| 09:30      | Script retested, restart successful, API operational                  |

---

## 🔍 Root Cause

PM2 was installed under the `ubuntu` user via `npm install -g`, making it unavailable to the `root` environment used by cron. This caused the automated restart to silently fail.

---

## 🛠️ Resolution

- Watchdog script updated:
  ```bash
  sudo su - ubuntu -c "/usr/bin/pm2 restart mern-backend"



Lessons Learned
PM2 is not globally available across users unless installed under system-wide configuration.

Cron has a minimal environment — PATH, NVM, NPM are not sourced.

Always use full command paths and user scoping in cron jobs.

Preventative Actions
Use full user-context with sudo su - ubuntu -c in watchdog and cron scripts.

Add log confirmation of restart outcome.

Append pm2 status check after restart and alert on failures.

👤 Incident Owner
Name: Edwin Joseph

Email: edj3650@gmailcom