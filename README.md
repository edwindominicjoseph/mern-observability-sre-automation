MERN SRE Automation 🚀

A production-grade, fully observable, and secure MERN stack deployment automated with Ansible on AWS EC2. This project integrates monitoring, alerting, SRE metrics (SLIs/SLOs), self-healing, and Slack notifications. Built with Production-grade reliability principles.

🌟 Objective

To deploy a reliable, secure, and scalable MERN (MongoDB, Express, React, Node.js) stack using Infrastructure as Code (IaC) and Site Reliability Engineering (SRE) practices.

✅ Tech Stack

Layer

Technology

Frontend

React (Vite), hosted on AWS S3 + CloudFront

Backend

Node.js (Express API), managed with PM2

Database

MongoDB Atlas (Cloud-hosted)

Infrastructure

AWS EC2, Ansible, NGINX, Let's Encrypt TLS

Monitoring

Prometheus, Grafana

Alerting

Prometheus Alertmanager + Slack

Exporters

node_exporter, pm2-exporter, custom metrics

Security

UFW, Fail2Ban, SSH hardening

Resilience

Cron watchdog, self-healing PM2 restarts

Testing

stress, k6 (load testing)

📊 Architecture Overview

Users ➔ CloudFront ➔ S3 (Static React App)
         └───➔ EC2 Instance (Node.js + PM2 + Exporters)
                        └───➔ MongoDB Atlas (Cloud)
                        └───➔ Prometheus ➔ Alertmanager ➔ Slack

🚧 Core Features

🔧 Infrastructure as Code

Modular Ansible roles: prometheus, alertmanager, nodejs-app

Automates provisioning, config, TLS, and monitoring setup

📊 Full Observability

Prometheus scrapes:

node_exporter for system

pm2-exporter for app

Custom Express /metrics

Grafana dashboards:

CPU & memory

Request latency & errors

MongoDB health

Burn rate & SLO compliance

📢 Alerting

Slack Integration via Alertmanager

Alerts for: high CPU, low memory, 5xx spike, high latency, low availability

Templated Slack messages with alert name, severity, description

Manual alert trigger support for testing

🔄 Self-Healing & Resilience

PM2 process management with restart policies

Cron-based watchdog: restarts Node.js if health fails

Hardened instance with UFW, Fail2Ban, SSH key-only access

🔢 SLIs and SLOs

SLI

SLO Target

API Availability

≥ 99.9%

CPU Usage

< 85% avg

Memory Availability

> 15%

5xx Error Rate

< 1%

95th Percentile Latency

< 500ms

Prometheus rules enforce these

Grafana shows error budget burn

🔍 Load & Stress Testing

stress used to simulate CPU & RAM load

k6 used for throughput and latency benchmarks

📚 Runbooks & Postmortems

runbook.md: how to respond to alerts

postmortem-template.md: RCA documentation

🛠️ Validation Commands

Check

Command

Prometheus targets

curl localhost:9090/targets

Alert rules loaded

`curl localhost:9090/api/v1/rules

jq`

Alert firing

`curl localhost:9090/api/v1/alerts

jq`

Send test alert

curl -XPOST http://localhost:9093/api/v2/alerts ...

Slack webhook test

curl -X POST -H 'Content-Type: application/json' ...

📈 Future Enhancements

Grafana Alerting (in addition to Prometheus)

Uptime probe monitoring

Slack silencing/resume via buttons

Multi-channel routing (pager, devops, etc)

Alert deduplication and inhibition tuning

🚀 Outcome

A real-world SRE-grade MERN stack deployment on AWS, built with resilience, observability, and automation at its core. Suitable for fintech, healthcare, or enterprise use cases.

Let me know if you want this exported as a GitHub README.md, rendered PDF, or included in your portfolio site.
