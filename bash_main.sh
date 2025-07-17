#!/bin/bash
# 🛰️ NC-FUZZ v2.1 | Robust Recon Engine by Neeraj Chansoriya

if [[ "$1" == "" ]]; then
  echo "Usage: $0 <domain> [--enrich]"
  exit 1
fi

DOMAIN=$1
ENRICH=false
[[ "$2" == "--enrich" ]] && ENRICH=true

echo -e "\e[1;96m[NC-FUZZ] Starting recon for: $DOMAIN\e[0m"
mkdir -p recon-$DOMAIN && cd recon-$DOMAIN

# Step 1: Subdomain Enumeration
echo "[*] Enumerating subdomains..."
subfinder -d $DOMAIN -silent > sub1.txt
assetfinder --subs-only $DOMAIN > sub2.txt
curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' > sub3.txt
cat sub1.txt sub2.txt sub3.txt | sort -u > all_subs.txt

# Step 2: DNS Resolution & Port Scanning
echo "[*] Validating DNS & scanning top 100 ports..."
dnsx -l all_subs.txt -silent -resp-only > resolved.txt
naabu -list resolved.txt -top-ports 100 -silent -o ports.txt

# Step 3: HTTP Probing
echo "[*] Probing web services with HTTPX..."
httpx -l resolved.txt -sc -title -tech-detect -server -tls-probe -json -o httpx.json

# Step 4: Risk Scoring
echo "[*] Calculating advanced risk scores..."
jq -r '
  [
    .url,
    (.title // "-"),
    (.webserver // "-"),
    (.tech | length),
    (.tls.tls_version // "-"),
    (.tls.not_after // "-"),
    (.cdn // false),
    (.content_length // 0),
    (.status_code // 0)
  ] | @tsv
' httpx.json > scored.tsv

awk -F '\t' '
BEGIN {
  print "url,risk_score,title,webserver,tls_version,cert_expiry,cdn,tech_count,content_length,status"
}
{
  score = 0
  url=$1; title=$2; server=$3; tech=$4; tls=$5; cert=$6; cdn=$7; length=$8; code=$9
  if (tolower(title) ~ /login|admin|signin|auth/) score += 2
  if (tls != "tls1.2" && tls != "tls1.3") score += 1
  if (length >= 1000) score += 1
  if (cdn == "true") score += 1
  score += tech
  print url "," score "," title "," server "," tls "," cert "," cdn "," tech "," length "," code
}
' scored.tsv > prioritized_assets.csv

# Step 5: Optional Enrichment
if $ENRICH; then
  echo "[*] Running Python enrichment..."
  python3 ../python_enrich.py < resolved.txt > enrichment.json
fi

# Step 6: Clean Report Assembly with Embedded Script
echo "[*] Generating visual HTML report..."
cp ../dashboard/header.html report.html
{
  echo "<script>"
  echo "const httpxData = ["
  jq -c '.' httpx.json | sed '$!s/$/,/'
  echo "];"
  echo "</script>" 
  cat ../dashboard/footer.html
} >> report.html

echo "[✓] Report complete: recon-$DOMAIN/report.html"
