 NC-FUZZ: Next-Gen ASM & Recon Toolkit

**By Neeraj Chansoriya**  |  🐉 Offensive Security Reconnaissance

---

## 🚀 Overview
`NC-FUZZ` is a powerful, modular, attacker-centric Automated External Reconnaissance and Attack Surface Management (ASM) toolkit. It maps an organization's external presence using DNS, HTTP, TLS, and metadata insights and scores assets by risk.

---

## 🔧 Features
- 🔍 Subdomain enumeration (Subfinder, Assetfinder, crt.sh)
- 🌐 DNS validation & port scanning (dnsx, naabu)
- 📡 Web probing and metadata collection (httpx)
- 🧠 Intelligent risk scoring
  - Login pages
  - Security header hygiene
  - TLS versions and cert expiry
  - CDN detection
  - Content length & technologies
  - Internal-only pattern detection
- 📊 Dynamic HTML reporting
- 🧩 Plugin-ready architecture (Shodan, Censys planned)

---

## 🛠️ Prerequisites
```bash
sudo ./install.sh
