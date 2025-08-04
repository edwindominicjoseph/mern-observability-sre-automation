# 🚀 MERN SRE Automation

A production-grade, fully observable, and secure MERN (MongoDB, Express, React, Node.js) stack deployment automated using **Ansible** on AWS EC2. Designed with real-world **Site Reliability Engineering (SRE)** best practices, this system includes monitoring, TLS, alerting, and self-healing.

---

## 🎯 Objective

To build a **reliable, scalable, and secure** infrastructure for a MERN application using:

- Configuration as Code (Ansible)
- HTTPS routing via ACM & Let's Encrypt
- SLO-driven alerting via Prometheus + Slack
- Continuous monitoring and recovery
- Load and burn-rate testing

---

## 🧰 Tech Stack

| Layer       | Technology / Tool                                |
|-------------|---------------------------------------------------|
| Frontend    | React (Vite) hosted on AWS S3 + CloudFront + ACM |
| Backend     | Node.js (Express API) behind NGINX (TLS)         |
| Domain Mgmt | Route 53 (DNS for custom domains)                |
| TLS Certs   | ACM (Frontend) & Let's Encrypt (Backend)         |
| Database    | MongoDB Atlas (cloud)                 |
| Process Mgmt| PM2 (with self-healing restarts)                 |
| Monitoring  | Prometheus, Node Exporter, PM2 Exporter          |
| Dashboards  | Grafana                                          |
| Alerting    | Alertmanager + Slack Webhook                     |
| Security    | UFW, Fail2Ban, SSH hardening, TLS everywhere     |
| Load Test   | stress, k6                                       |

---

## 🧱 Architecture

```text
Users ─▶ Route 53 ─▶ CloudFront (TLS via ACM) ─▶ S3 (React App)
                              │
                              ▼
                 HTTPS via NGINX + Let's Encrypt TLS
                              │
                 EC2 Instance (API + Exporters + PM2)
                              │
                              ▼
                      MongoDB Atlas (Managed DB)
                              │
                              ▼
    Prometheus + Alertmanager + Grafana (Monitoring Stack)
                              │
                              ▼
                        Slack (Incident Alerts)





---

🔐 Security Highlights
✅ Frontend (S3 + CloudFront + ACM)
HTTPS via ACM TLS (auto-renewed)

CloudFront OAC prevents direct bucket access

Route 53 manages domain routing

S3 bucket policies allow access only via CloudFront

✅ Backend (EC2 + NGINX + Let's Encrypt)
NGINX with auto-renewed Let's Encrypt TLS

Enforced HTTPS & reverse proxy

CORS-restricted origins in Express app

PM2 crash recovery

Fail2Ban for SSH brute-force protection

UFW firewall (only ports 22, 443 open)

📈 Observability
Metrics Sources
node_exporter: EC2 health (CPU, memory, disk)

pm2-exporter: Process-level status

/metrics endpoint: App-level custom metrics

Grafana Dashboards
CPU/Memory/Disk usage

Request durations & status codes

MongoDB connectivity

SLO error budget burn rate

🔔 Alerting (Prometheus → Alertmanager → Slack)
Prometheus Alert Rules
Alert Name	Condition
HighCPUUsage	CPU > 85% for 2 mins
HighMemoryUsage	Free memory < 15%
HighErrorRate	HTTP 5xx > 1%
HighLatency95th	95th percentile > 500ms
APIAvailabilityBelowSLO	Success rate < 99.9%

Slack Message Example
🔔 *HighCPUUsage*
🖥 Instance: ip-172-31-x-x
⚠ Severity: warning
📝 CPU usage exceeds 85%
🔁 Self-Healing
PM2 restart-on-failure

Health-check watchdog (cronjob)

Auto TLS renewal (Certbot)

Alert-based manual/automated mitigation

🧪 Load Testing
stress: CPU, memory stress tests

k6: Simulate concurrent API load

curl: Trigger manual alerts for testing

📘 Operational Docs
File	Purpose
runbook.md	Steps to handle each alert
postmortem-template.md	Root Cause Analysis format
group_vars/all.yml	Configuration for domains, Slack, TLS

✅ How to Deploy
Step 1: Clone Repo
bash
Copy
Edit
git clone https://github.com/your-username/mern-sre-automation.git
cd mern-sre-automation
Step 2: Configure Variables
Edit group_vars/all.yml

domain_name: api.yourdomain.com
frontend_domain: mern.yourdomain.com
acm_certificate_arn: arn:aws:acm:us-east-1:XXXX
slack_webhook_url: https://hooks.slack.com/services/XXX/YYY/ZZZ
Step 3: Run Ansible

ansible-playbook -i inventory playbook.yml
Step 4: Access Services
Service	URL
Frontend	https://mern.yourdomain.com
Backend API	https://api.yourdomain.com/api/...
Prometheus	http://<ec2-ip>:9090
Alertmanager	http://<ec2-ip>:9093
Grafana	http://<ec2-ip>:3000
Slack Alerts	Sent to configured channel

