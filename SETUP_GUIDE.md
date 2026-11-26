# 🚀 Panduan Setup & Menjalankan Curhatin App (Backend + Mobile)

File database SQL dari Anda sudah diletakkan di:
`backend/database/curhatin.sql`

---

## 1. Import Database ke MySQL (Laragon / XAMPP)

1. Pastikan **MySQL** sudah aktif (misal klik **Start All** di Laragon).
2. Buat database `curhatin` dan import file `curhatin.sql`.

### Cara Cepat via Terminal / Command Prompt:
```bash
mysql -u root -e "CREATE DATABASE IF NOT EXISTS curhatin;"
mysql -u root curhatin < "backend/database/curhatin.sql"
```

*Atau bisa juga import via HeidiSQL / phpMyAdmin (buat database `curhatin` lalu import file `backend/database/curhatin.sql`).*

---

## 2. Menjalankan Backend Laravel

Buka terminal di folder `backend/`:

```bash
# 1. Jalankan server Laravel (port 8000)
php artisan serve
```

Server backend akan aktif di: `http://127.0.0.1:8000`

> File `.env` sudah otomatis dikonfigurasikan untuk database `curhatin` dengan `DB_USERNAME=root` dan `DB_PASSWORD=`.

---

## 3. Menjalankan Aplikasi Flutter (Mobile App)

Buka terminal di folder `apps/mobile/`:

```bash
# 1. Install dependencies
flutter pub get

# 2. Jalankan aplikasi
flutter run
```

### 📱 Catatan Koneksi Emulator vs HP Fisik:
- **Android Emulator**: Otomatis mengakses backend melalui `http://10.0.2.2:8000/api`.
- **Windows Desktop / Web**: Otomatis mengakses `http://127.0.0.1:8000/api`.
- **HP Fisik**: Jika ingin test di HP fisik via kabel/WiFi, ubah `baseUrl` di `apps/mobile/lib/services/api_service.dart` ke IP laptop Anda (misal `http://192.168.1.xxx:8000/api`).

---

## 4. Endpoint API yang Sudah Tersambung

| Method | Endpoint | Deskripsi | Status di Frontend |
|---|---|---|---|
| `POST` | `/api/register` | Daftar akun baru (nama, telepon, password) | Tersambung di `RegisterPage` |
| `POST` | `/api/login` | Masuk akun (nomor telepon & password) | Tersambung di `LoginPage` |
| `POST` | `/api/logout` | Logout akun | Tersedia di `ApiService` |
| `GET` | `/api/journals` | Ambil daftar jurnal aktif | Tersambung di `JournalPage` |
| `GET` | `/api/journals/trash` | Ambil daftar kotak sampah jurnal | Tersambung di `JournalPage` |
| `POST` | `/api/journals` | Buat jurnal baru | Tersambung di `JournalWritePage` |
| `PUT` | `/api/journals/{id}` | Update catatan jurnal | Tersambung di `JournalWritePage` |
| `DELETE` | `/api/journals/{id}` | Pindahkan jurnal ke kotak sampah | Tersambung di `JournalPage` |
| `POST` | `/api/journals/{id}/restore` | Pulihkan jurnal dari sampah | Tersambung di `JournalPage` |
| `DELETE` | `/api/journals/{id}/permanent` | Hapus permanen jurnal | Tersambung di `JournalPage` |
