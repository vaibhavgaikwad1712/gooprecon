# gooprecon
gooprecon is a lightweight, modular bug bounty reconnaissance tool designed to perform essential recon tasks with minimal network noise. It acts as a smart wrapper around proven open‑source tools, focusing on clean output, speed, and real‑world bug bounty workflows.  ⚡ One command. Clean recon. Actionable results.

✨ Features

🔍 Subdomain enumeration

🌐 Live host detection

🔌 Port scanning (low‑noise)

🕰️ Wayback URL collection (GAU)

🧩 Parameter discovery

📦 JavaScript file extraction

🔐 Sensitive secrets detection in JS files

📁 Directory brute‑forcing

🧠 Special service / tech identification

🛡️ Nikto scan (conditional)

🧪 WordPress detection & WPScan

📂 Well‑structured output per module

🎯 Design Philosophy

Lightweight & fast (single binary)

Modular (run only what you need)

Low network noise (rate‑limited & conditional scans)

Bug bounty focused (signal > noise)

Readable output (easy triage)

🛠️ Requirements

gooprecon is a wrapper. You need the following tools installed and available in $PATH:

subfinder

assetfinder (optional)

httpx

nmap

gau

uro

ffuf

nikto

wpscan

👉 Recommended OS: Linux / macOS

📦 Installation
Option 1: Download Prebuilt Binary (Recommended)
wget https://github.com/<your-username>/gooprecon/releases/latest/download/gooprecon
chmod +x gooprecon
sudo mv gooprecon /usr/local/bin/
Option 2: Build from Source
git clone https://github.com/<your-username>/gooprecon.git
cd gooprecon
go build -o gooprecon
sudo mv gooprecon /usr/local/bin/

Verify:

gooprecon -h
🚀 Usage
Basic Recon
gooprecon -d example.com
Fast Mode (Low Noise)
gooprecon -d example.com --fast
Disable Specific Modules
gooprecon -d example.com --no-nmap --no-nikto
Custom Output Directory
gooprecon -d example.com -o recon-example
⚙️ Configuration

gooprecon uses a YAML config file:

threads: 50
timeout: 10
run:
  subdomains: true
  nmap: true
  gau: true
  js_secrets: true
  ffuf: true
  nikto: false
  wpscan: true
wordlists:
  ffuf: small.txt

Config path:

~/.config/gooprecon/config.yaml
📁 Output Structure
recon/
├── subdomains/
├── ports/
├── urls/
├── params/
├── js/
│   ├── files/
│   └── secrets/
├── dirs/
├── cms/
├── vulns/
└── reports/

Each module saves:

raw.txt

clean.txt

summary.txt

🔐 JavaScript Secret Detection

gooprecon scans extracted JS files for:

API keys

Tokens

Secrets

Authorization headers

AWS keys

Firebase configs

Results are saved in:

recon/js/secrets/
🧠 Special Service Detection

Identifies interesting subdomains such as:

Admin panels

Dashboards

Jenkins

Grafana

Kibana

GitLab

Saved as:

recon/reports/interesting-services.txt
⚠️ Disclaimer

This tool is intended only for authorized security testing and bug bounty programs. The author is not responsible for misuse.

🤝 Contributing

Contributions are welcome!

Fork the repo

Create a feature branch

Submit a PR

Ideas:

New recon modules

Better secret regex

Performance improvements

📜 License

MIT License

⭐ Support

If you find gooprecon useful:

⭐ Star the repository

🐛 Report issues

💡 Suggest features

Happy hacking 👊
