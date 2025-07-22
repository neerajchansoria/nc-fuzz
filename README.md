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

## 🧭 Project Structure

```
bash
nc-fuzz/
├── bash_main.sh           # Main recon engine
├── install.sh             # Installer for dependencies
├── Dir(dashboard)h--- copy both header.html / footer.html
├── README.md / LICENSE
└── .github/workflows/     # CI setup

-------

## 🛠️ Prerequisites & Usage:
1. Run `install.sh` to set up tools
2. Run `bash_main.sh <domain> [--enrich]`
3. View report in `recon-<domain>/report.html`
