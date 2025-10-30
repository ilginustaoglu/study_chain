# Asset Manifest Düzeltmesi ✅

## Sorun

```
ActionView::Template::Error (Asset `application.css` was not declared to be precompiled in production.
Declare links to your assets in `app/assets/config/manifest.js`.
```

## Neden

Dart Sass, CSS'i `app/assets/builds/` klasörüne derliyor, ama Sprockets manifest'i hala `app/assets/stylesheets/` klasöründen CSS arıyordu.

## Çözüm

### app/assets/config/manifest.js

**Eski:**
```javascript
//= link_tree ../images
//= link_directory ../stylesheets .css  // ❌ Yanlış
//= link_tree ../../javascript .js
//= link_tree ../../../vendor/javascript .js
```

**Yeni:**
```javascript
//= link_tree ../images
//= link_tree ../builds  // ✅ Doğru - Derlenmiş CSS burada
//= link_tree ../../javascript .js
//= link_tree ../../../vendor/javascript .js
```

## Nasıl Çalışıyor?

### 1. Dart Sass Derleme
```bash
bin/rails dartsass:build
```

**Kaynak:**
```
app/assets/stylesheets/application.scss
```

**Çıktı:**
```
app/assets/builds/application.css  ← Derlenmiş CSS burada
```

### 2. Sprockets Manifest
`app/assets/config/manifest.js` Sprockets'e hangi dosyaları precompile edeceğini söyler:

```javascript
//= link_tree ../builds
```

Bu, `app/assets/builds/` klasöründeki tüm dosyaları (application.css dahil) asset pipeline'a ekler.

### 3. Layout
`app/views/layouts/application.html.erb`:

```erb
<%= stylesheet_link_tag 'application', media: 'all', 'data-turbo-track': 'reload' %>
```

Bu, `app/assets/builds/application.css` dosyasını yükler.

## Klasör Yapısı

```
app/assets/
├── builds/                    # Derlenmiş CSS'ler (Dart Sass çıktısı)
│   └── application.css       # ← Sprockets bunu kullanır
├── config/
│   └── manifest.js           # ← Sprockets manifest
├── images/
└── stylesheets/              # Kaynak SCSS dosyaları
    ├── application.scss      # Ana SCSS dosyası
    ├── navigation.scss
    ├── devise.scss
    └── ...
```

## Development vs Production

### Development
```bash
# Watch mode - otomatik derleme
bin/rails dartsass:watch

# Veya bin/dev ile
bin/dev
```

CSS değiştiğinde otomatik olarak `app/assets/builds/application.css` güncellenir.

### Production
```bash
# CSS'i derle
bin/rails dartsass:build

# Assets'i precompile et
bin/rails assets:precompile
```

Bu, CSS'i `public/assets/` klasörüne kopyalar.

## Doğrulama

✅ `app/assets/config/manifest.js` güncellendi
✅ `//= link_tree ../builds` eklendi
✅ CSS artık doğru klasörden yükleniyor

## Şimdi Başlatın

```bash
# Sunucuyu yeniden başlatın
bin/dev
```

Veya:
```bash
# Terminal 1
bin/rails server

# Terminal 2
bin/rails dartsass:watch
```

Tarayıcıda açın:
```
http://localhost:3000
```

Artık CSS düzgün yüklenmeli! 🎉

---

**Son Güncelleme:** 26 Ekim 2025
**Durum:** ✅ Asset manifest düzeltildi

