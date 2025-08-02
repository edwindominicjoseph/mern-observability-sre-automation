# 🚀 MERN SRE Automation

A production-ready, fully observable, and secure MERN (MongoDB, Express, React, Node.js) stack deployment automated using **Ansible** on AWS EC2. This project integrates full-stack observability, real-time alerting, self-healing, and stress testing, designed with real-world **Site Reliability Engineering (SRE)** best practices.

---

## 🎯 Objective

To build a reliable, secure, and self-healing infrastructure for a MERN application using:
- Infrastructure as Code (IaC)
- SLO-driven alerting
- Monitoring, logging, and alert routing via Prometheus & Alertmanager
- Slack integration for incident notification
- Stress & burn rate testing

---

## 🧰 Tech Stack

| Layer       | Technology / Tool                                |
|-------------|---------------------------------------------------|
| Frontend    | React (Vite) hosted on AWS S3 + CloudFront       |
| Backend     | Node.js (Express API) managed by PM2             |
| Database    | MongoDB Atlas                                     |
| Process Mgmt| PM2 (with custom health checks)                  |
| Automation  | Ansible (multi-role architecture)                |
| Monitoring  | Prometheus, Node Exporter, PM2 Exporter          |
| Dashboards  | Grafana                                          |
| Alerting    | Alertmanager + Slack Webhook                     |
| Security    | UFW, Fail2Ban, Let's Encrypt TLS via NGINX       |
| Load Test   | stress, k6                                       |

---

## 🧱 Architecture

```text
Users ─▶ CloudFront (CDN) ─▶ S3 (React Frontend)
            │
            ▼
     EC2 Instance (Express API + PM2 + Exporters)
            │
            ▼
     MongoDB Atlas (Cloud-hosted)
            │
            ▼
   Prometheus + Grafana + Alertmanager (Monitoring & Alerting)
                                   │
                                   ▼
                            Slack Notifications




🔧 Features
✅ Infrastructure as Code
Modular Ansible roles for Prometheus, Alertmanager, Node Exporter, PM2 exporter, TLS setup

Auto-provisions EC2 instances, configures NGINX reverse proxy with HTTPS

📈 Full Observability
node_exporter, pm2-exporter, and custom /metrics for app-level visibility

Prometheus scrapes and stores time-series metrics

Grafana dashboards include:

CPU, memory, disk

API latency and error rate

MongoDB availability (optional)

SLO burn rate

🔔 Real-Time Alerting (Prometheus → Alertmanager → Slack)
Alerts defined using PromQL

Slack webhook integration

Sample rules:

High CPU/memory

5xx error rate > 1%

Availability < 99.9%

Latency > 500ms

⚠️ Sample Alert Payload
yaml
Copy
Edit
🔔 *HighCPUUsage*
🖥 Instance: ip-172-31-x-x
⚠ Severity: warning
📝 CPU usage exceeds 85%
🔁 Self-Healing
PM2 restart on crash

Health-check watchdog (via cronjob)

Recovery auto-triggered if unresponsive

🔐 Security Hardening
UFW firewall: only essential ports open

Fail2Ban: brute-force protection

Let's Encrypt SSL on NGINX

Key-based SSH only (no passwords)

🧪 Load Testing & Validation
stress: simulate CPU/memory pressure

k6: simulate concurrent API traffic

curl to test Alertmanager API with manual alerts

📄 Alerting Rules Summary
Alert Name	Trigger Condition
HighCPUUsage	CPU > 85% for 2 mins
HighMemoryUsage	Free mem < 15% for 2 mins
HighErrorRate	5xx errors > 1%
HighLatency95th	95th percentile > 500ms
APIAvailabilityBelowSLO	Success rate < 99.9%

📘 Runbooks & Postmortems
runbook.md: Operational response steps per alert type

postmortem-template.md: Root Cause Analysis (RCA) documentation format

✅ How to Use
Step 1: Clone & Configure
bash
Copy
Edit
git clone https://github.com/your-username/mern-sre-automation.git
cd mern-sre-automation
Step 2: Set your variables in group_vars/all.yml
yaml
Copy
Edit
slack_webhook_url: "https://hooks.slack.com/services/XXX/YYY/ZZZ"
slack_channel: "#all-edwin"
Step 3: Run Ansible
bash
Copy
Edit
ansible-playbook -i inventory playbook.yml
Step 4: Validate in Browser
Prometheus: http://<ec2-ip>:9090

Alertmanager: http://<ec2-ip>:9093

Grafana (optional): http://<ec2-ip>:3000

Slack: Check configured channel for alerts

📦 Coming Soon
Terraform version

Grafana-as-code provisioning

Loki + EFK stack for logging

PagerDuty integration
