# 🚀 Panduan Setup Curhatin App

## 1. Setup Flutter (Mobile App)

Buka terminal di folder `apps/mobile/`, jalankan:

```bash
flutter pub get
```

> Ini menginstall package `http` yang sudah ditambahkan di `pubspec.yaml`.

---

## 2. Setup Backend Laravel

Buka terminal di folder `backend/`, jalankan satu per satu:

```bash
# 1. Copy file environment
copy .env.example .env

# 2. Generate app key
php artisan key:generate

# 3. Jalankan migrasi database (termasuk kolom phone baru)
php artisan migrate

# 4. Jalankan server lokal Laravel
php artisan serve
```

Backend akan berjalan di: `http://127.0.0.1:8000`

---

## 3. Endpoint API yang Tersedia

| Method | URL | Deskripsi |
|--------|-----|-----------|
| `POST` | `/api/register` | Daftar akun baru |
| `POST` | `/api/login` | Login |
| `POST` | `/api/logout` | Logout (butuh token) |
| `GET` | `/api/profile` | Profil user (butuh token) |

### Contoh Body Register (JSON):
```json
{
  "name": "Budi Santoso",
  "phone": "81234567890",
  "password": "rahasia123",
  "password_confirmation": "rahasia123"
}
```

### Contoh Body Login (JSON):
```json
{
  "phone": "81234567890",
  "password": "rahasia123"
}
```

---

## 4. Jalankan Aplikasi Flutter

```bash
flutter run
```

Pastikan emulator atau device Android/iOS sudah aktif.

