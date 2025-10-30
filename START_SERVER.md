# Rails 8 Sunucusunu Başlatma

## ✅ Sorun Çözüldü - Artık Başlatabilirsiniz!

### Önerilen Yöntem (En Kolay)

```bash
bin/dev
```

Bu komut hem Rails server'ı hem de CSS watch mode'u başlatır.

### Manuel Başlatma

Eğer `bin/dev` çalışmazsa, iki ayrı terminal kullanın:

#### Terminal 1: Rails Server
```bash
bin/rails server
```

#### Terminal 2: CSS Watch
```bash
bin/rails dartsass:watch
```

### Sorun Giderme

#### 1. "Server is already running" Hatası

```bash
# Tüm Rails process'lerini durdur
pkill -9 -f puma

# PID dosyasını sil
rm -f tmp/pids/server.pid

# Tekrar başlat
bin/dev
```

#### 2. "LoadError: cannot load such file -- sassc" Hatası

Bu hata artık çözülmüş olmalı. Eğer hala görüyorsanız:

```bash
# Cache'i temizle
rm -rf tmp/cache/*

# Bootsnap cache'i temizle
rm -rf tmp/cache/bootsnap*

# Bundle'ı yeniden yükle
bundle install

# Tekrar başlat
bin/dev
```

#### 3. CSS Yüklenmiyor

```bash
# CSS'i derle
bin/rails dartsass:build

# Assets'i precompile et
bin/rails assets:precompile

# Sunucuyu yeniden başlat
bin/dev
```

#### 4. Port 3000 Kullanımda

```bash
# Port 3000'i kullanan process'i bul ve durdur
lsof -ti:3000 | xargs kill -9

# Veya farklı port kullan
bin/rails server -p 3001
```

### Doğrulama

Sunucu başladıktan sonra tarayıcıda açın:
```
http://localhost:3000
```

Şunları görmelisiniz:
- ✅ Sayfa yükleniyor
- ✅ CSS stilleri uygulanmış
- ✅ JavaScript çalışıyor
- ✅ Console'da hata yok

### Hata Ayıklama

Eğer hala sorun yaşıyorsanız:

```bash
# Rails console'u test edin
bin/rails console

# İçinde:
Rails.version
# => "8.0.3"

User.first
# => Bir user objesi dönmeli
```

### Log Kontrolü

```bash
# Development log'unu takip edin
tail -f log/development.log
```

Başka bir terminalde sunucuyu başlatın ve log'da hataları görün.

## Başarılı Başlatma Çıktısı

Şuna benzer bir çıktı görmelisiniz:

```
=> Booting Puma
=> Rails 8.0.3 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 7.1.0 (ruby 3.2.2-p53) ("Moonstone")
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```

## Yardım

Eğer hala sorun yaşıyorsanız, tam hata mesajını paylaşın:
- Hangi komutu çalıştırdınız?
- Tam hata mesajı nedir?
- Tarayıcıda mı yoksa terminalde mi hata aldınız?

---

**Not:** Tüm `sassc` referansları kaldırıldı ve Dart Sass kullanıma hazır!

