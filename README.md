# zeed-uptime

zeedmobile.com'u GitHub Actions ile kontrol eder. Site açılmazsa `kesinti` etiketli bir issue açılır (GitHub e-posta gönderir), site açılınca issue kapanır.

- Hafta sonu ve hafta içi 23:00–09:00 (TR): 10 dakikada bir
- Hafta içi 09:00–23:00 (TR): saatte bir
- Kontrol: `/tr/` ve `/tr/z-slim/`, 200 ve sayfada "ZEED" yazısı; 3 deneme, 30 sn arayla
- Elle test: Actions → "zeedmobile.com kontrol" → Run workflow → "Kesinti sahnele"

GitHub zamanlanmış görevleri 5–20 dk gecikebilir. Kesinti geçmişi: Issues → `kesinti` etiketi.
