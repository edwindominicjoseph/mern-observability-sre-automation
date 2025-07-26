# MERN DevOps Automation 🚀

This repository automates the deployment of a production-grade MERN (MongoDB, Express, React, Node.js) stack using **Ansible** on **AWS EC2**, with optional React frontend hosting on **S3 + CloudFront**. It also includes **full observability** using **Prometheus + Grafana**.

---

## 📌 Project Objective

To provision a secure, scalable, and observable MERN stack using Infrastructure as Code, fully automated via Ansible.

---

## ✅ Tech Stack

| Layer       | Tech Used                     |
|-------------|-------------------------------|
| Frontend    | React (Vite), hosted on S3     |
| Backend     | Node.js (Express API)          |
| Database    | MongoDB Atlas                  |
| DevOps      | Ansible, SSH, PM2              |
| Deployment  | AWS EC2, S3, CloudFront        |
| Secrets Mgmt| Ansible Vault                  |
| Monitoring  | Prometheus, Grafana (required) |

---

## 🔧 Planned Architecture

```plaintext
Users ──▶ CloudFront (CDN) ──▶ S3 (React Frontend)
               │
               ▼
       EC2 Instance (Node.js + PM2 + Exporters)
               │
               ▼
        MongoDB Atlas (Cloud DB)
               │
               ▼
        Prometheus + Grafana (Monitoring)
