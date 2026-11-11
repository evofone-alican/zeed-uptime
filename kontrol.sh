#!/usr/bin/env bash
# Her adres 3 kez denenir (30 sn arayla). Hepsi başarısızsa "kapali".
ADRESLER="https://zeedmobile.com/tr/ https://zeedmobile.com/tr/z-slim/"
durum=acik; detay=""
for u in $ADRESLER; do
  ok=0
  for i in 1 2 3; do
    if [ "$TEST" = "true" ]; then kod="TEST"; break; fi
    kod=$(curl -s -o /tmp/s.html -w '%{http_code}' --max-time 25 -A 'zeed-uptime' "$u?k=$(date +%s)")
    if [ "$kod" = "200" ] && grep -q 'ZEED' /tmp/s.html; then ok=1; break; fi
    [ $i -lt 3 ] && sleep 30
  done
  if [ $ok = 0 ]; then durum=kapali; detay="$detay- $u → ${kod:-yanıt yok}"$'\n'; fi
  echo "$u ok=$ok kod=$kod"
done
echo "durum=$durum" >> "$GITHUB_OUTPUT"
{ echo 'detay<<EOF'; printf '%s' "$detay"; echo; echo 'EOF'; } >> "$GITHUB_OUTPUT"
