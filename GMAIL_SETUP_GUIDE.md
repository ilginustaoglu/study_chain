# 📧 Gmail SMTP Setup Guide

## 🎯 Email Doğrulama Sistemi

StudyChain artık **kod ile email doğrulama** sistemi kullanıyor:
- ✅ Sign up sonrası 6 haneli kod gönderilir
- ✅ Kullanıcı kodu girerek hesabını aktive eder
- ✅ Kod 30 dakika geçerli
- ✅ **Login'de kod istenmez** - sadece email/şifre ile giriş

## 🔧 Gmail App Password Nasıl Alınır?

### Adım 1: Google Hesabı Ayarları
1. Google hesabına git: https://myaccount.google.com/
2. Sol menüden **"Security"** (Güvenlik) seçeneğini tıkla

### Adım 2: 2-Step Verification Aktif Et
1. **"2-Step Verification"** bölümünü bul
2. Eğer aktif değilse, aktive et
3. Telefon numarası doğrulaması gerekebilir

### Adım 3: App Password Oluştur
1. Güvenlik sayfasında **"App passwords"** (Uygulama şifreleri) ara
2. "App passwords" linkine tıkla
3. **"Select app"** dropdown'ından **"Mail"** seç
4. **"Select device"** dropdown'ından **"Other"** seç
5. İsim gir: "StudyChain"
6. **"Generate"** butonuna tıkla
7. **16 haneli şifre** gösterilecek (örnek: `abcd efgh ijkl mnop`)
8. ⚠️ **Bu şifreyi kopyala ve sakla!** Tekrar gösterilmeyecek

### Adım 4: Environment Variable Ayarla

Terminal'de şu komutu çalıştır:

```bash
export GMAIL_PASSWORD='your-16-digit-app-password'
```

**Örnek:**
```bash
export GMAIL_PASSWORD='abcd efgh ijkl mnop'
```

**Kalıcı olması için** (her terminal açılışında otomatik ayarlansın):

**macOS/Linux (zsh):**
```bash
echo 'export GMAIL_PASSWORD="your-16-digit-app-password"' >> ~/.zshrc
source ~/.zshrc
```

**macOS/Linux (bash):**
```bash
echo 'export GMAIL_PASSWORD="your-16-digit-app-password"' >> ~/.bashrc
source ~/.bashrc
```

### Adım 5: Server'ı Başlat
```bash
rails server
```

## 🚀 Sistem Nasıl Çalışıyor?

### 1. Sign Up Akışı
```
User Sign Up 
    ↓
reCAPTCHA Doğrulama
    ↓
Kullanıcı Kaydedilir (confirmed_at = null)
    ↓
6 Haneli Kod Üretilir
    ↓
📧 Email Gönderilir (ilginustaolgu@gmail.com'dan)
    ↓
Kullanıcı Verification Sayfasına Yönlendirilir
    ↓
Kod Girilir
    ↓
✅ Hesap Aktive Edilir (confirmed_at = Time.current)
    ↓
Login Sayfasına Yönlendirilir
```

### 2. Login Akışı
```
User Login
    ↓
Email/Şifre Kontrolü
    ↓
confirmed_at var mı?
    ├─ Evet → ✅ Giriş Başarılı
    └─ Hayır → ⚠️ "Email doğrulama gerekli" → Verification sayfası
```

### 3. Kod Tekrar Gönderme
- Verification sayfasında "Resend Code" butonu var
- Yeni kod üretilir ve gönderilir
- Eski kod geçersiz olur

## 📧 Email Template Özellikleri

**HTML Email:**
- 🎨 Mavi gradient header
- 🔐 Büyük, vurgulu 6 haneli kod
- ⏱️ 30 dakika uyarısı
- 📋 Güvenlik bilgileri
- 📱 Responsive tasarım

**Plain Text Email:**
- Basit, okunabilir format
- Tüm bilgiler dahil
- Email client'ı HTML desteklemiyorsa gösterilir

## 🔐 Güvenlik Özellikleri

1. **Kod Süresi**: 30 dakika sonra geçersiz
2. **Tek Kullanımlık**: Kod kullanıldıktan sonra silinir
3. **Şifreli Saklama**: Kodlar database'de saklanır
4. **Rate Limiting**: Spam önleme (gelecekte)
5. **reCAPTCHA**: Bot kayıtları engeller

## 📝 Database Yapısı

```ruby
# users tablosu eklenen sütunlar:
- verification_code: string           # 6 haneli kod (123456)
- verification_code_sent_at: datetime # Gönderim zamanı
- confirmed_at: datetime              # Doğrulama zamanı
```

## 🧪 Test Etme

### 1. Sign Up Test
```bash
# Server başlat
rails server

# Browser'da aç
http://localhost:3000/users/sign_up

# Formu doldur:
- Full Name: Test User
- Email: test@example.com
- Password: password123
- Confirm Password: password123
- reCAPTCHA: Tıkla

# Sign up tıkla
# → Email gidecek (Gmail hesabını kontrol et!)
# → Verification sayfasına yönlenecek
```

### 2. Email Kontrolü
- Gmail hesabına gir: ilginustaolgu@gmail.com
- "StudyChain" araması yap
- Email'i aç
- **6 haneli kodu** kopyala

### 3. Kod Girme
- Verification sayfasında kodu yapıştır
- "Verify Email" tıkla
- ✅ Başarı mesajı göreceksin
- Login sayfasına yönleneceksin

### 4. Login Test
- Email: test@example.com
- Password: password123
- "Log in" tıkla
- ✅ Giriş başarılı!

## 🐛 Sorun Giderme

### Email Gitmiyor?
1. Environment variable ayarlı mı?
   ```bash
   echo $GMAIL_PASSWORD
   ```
2. App password doğru mu? (16 haneli, boşluklarla)
3. 2-Step Verification aktif mi?
4. Server log'una bak:
   ```bash
   tail -f log/development.log
   ```

### "Invalid credentials" Hatası?
- App password'ü kontrol et
- Boşlukları kaldır: `abcdefghijklmnop`
- Tek tırnak içinde olmalı: `'abcdefghijklmnop'`

### Kod Çalışmıyor?
- 30 dakikadan eski mi?
- Doğru kodu girdiğinden emin misin?
- "Resend Code" ile yeni kod iste

### Email Spam'e Düşmüş?
- Gmail'de Spam klasörünü kontrol et
- "Not Spam" işaretle
- Gelecek email'ler Inbox'a gelecek

## 📁 İlgili Dosyalar

### Controllers
- `app/controllers/users/registrations_controller.rb` - Sign up & kod gönderme
- `app/controllers/users/sessions_controller.rb` - Login & email kontrolü
- `app/controllers/verifications_controller.rb` - Kod doğrulama

### Models
- `app/models/user.rb` - Kod üretme ve doğrulama metodları

### Views
- `app/views/verifications/new.html.erb` - Kod girme sayfası
- `app/views/user_mailer/verification_code.html.erb` - HTML email
- `app/views/user_mailer/verification_code.text.erb` - Text email

### Config
- `config/environments/development.rb` - Gmail SMTP ayarları
- `config/locales/devise.en.yml` - Flash mesajları

## 🎉 Özet

✅ Gmail SMTP ile email gönderimi
✅ 6 haneli kod sistemi
✅ 30 dakika geçerlilik süresi
✅ Güzel HTML email template
✅ Resend code özelliği
✅ Login'de sadece email doğrulaması kontrolü
✅ reCAPTCHA bot koruması

**Sign Up → Email → Kod Gir → Login → Kullan!** 🚀

