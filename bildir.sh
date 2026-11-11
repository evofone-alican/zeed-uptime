#!/usr/bin/env bash
# Kapalıysa ve açık kesinti issue'su yoksa açar; açıksa ve issue varsa kapatır. Her değişimde GitHub e-posta atar.
saat=$(TZ=Europe/Istanbul date '+%d.%m.%Y %H:%M')
acik=$(gh issue list --label kesinti --state open --json number --jq '.[0].number')
gh label create kesinti --color d73a4a --description 'Site erişilemedi' 2>/dev/null || true
if [ "$DURUM" = "kapali" ] && [ -z "$acik" ]; then
  gh issue create --label kesinti --title "🔴 zeedmobile.com AÇILMIYOR ($saat)" --body "$(printf 'Kontrol zamanı (TR): %s\n\nAçılmayan adresler (3 deneme, 30 sn arayla):\n%s\n\nSite açılınca bu kayıt otomatik kapanır.\n\n@evofone-alican' "$saat" "$DETAY")"
elif [ "$DURUM" = "acik" ] && [ -n "$acik" ]; then
  gh issue comment "$acik" --body "🟢 Site tekrar açık: $saat (TR). @evofone-alican"
  gh issue close "$acik"
else
  echo "değişiklik yok: $DURUM, açık kayıt: ${acik:-yok}"
fi
