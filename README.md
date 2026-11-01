
# ☕ Sidelake Roastery Mobile App

> **Project Ujian Tengah Semester (UTS) Pemrograman Mobile**  
> Program Studi Teknologi Rekayasa Perangkat Lunak (TRPL)  
> Jurusan Teknik Informatika, Fakultas Teknik dan Kejuruan (FTK)  
> Universitas Pendidikan Ganesha (Undiksha)

---

## 👤 Identitas Mahasiswa

* **Nama**: Kadek Ripa Adi Putra
* **NIM**: 2455011011
* **Kelas**: TRPL 5A 
* **Dosen Pengampu**: Dr. Ir. I Ketut Resika Arthana, S.T., M.Kom.
* **Teaching Assistant**: Made Yuda Sadewa, S.Pd.

---

## 📌 Deskripsi Aplikasi

**Sidelake Roastery App** adalah aplikasi mobile berbasis Flutter yang dirancang untuk pecinta kopi dan bisnis *roastery*. Aplikasi ini mengintegrasikan katalog biji kopi dari REST API dengan sistem pencatatan pribadi (*Brew Journal*) yang terhubung langsung ke backend database Supabase.

Aplikasi ini dibangun menggunakan arsitektur berlapis (*Clean Architecture*) dengan pendekatan manajemen state `Provider` untuk memastikan kode modular, scalable, dan type-safe.

---

## ✨ Fitur Utama

- 🏠 **Dashboard / Home**: Menampilkan banner promo, navigasi cepat, dan ringkasan menu utama.
- ☕ **Katalog Biji Kopi (REST API)**: Menampilkan daftar produk biji kopi pilihan dari REST API.
- 📖 **Detail Produk**: Menampilkan asal daerah (*origin*), profil sangrai (*roast level*), harga, dan deskripsi lengkap biji kopi.
- 📝 **Jurnal Seduh Pribadi (Supabase CRUD)**:
  - **Create**: Menambah catatan hasil seduhan kopi baru (metode, tingkat gilingan, rating, dan catatan rasa).
  - **Read**: Menampilkan daftar seluruh jurnal seduh tersimpan.
  - **Update**: Memperbarui informasi jurnal seduh yang pernah dibuat.
  - **Delete**: Menghapus catatan jurnal seduh dengan dialog konfirmasi (*Confirmation Dialog*).
- 👤 **Profil Pengguna**: Informasi mahasiswa pengembang aplikasi dan identitas UTS.

---

## 🛠️ Tech Stack & Dependencies

* **Framework**: Flutter (Dart)
* **State Management**: `provider` (ChangeNotifier)
* **Backend & Database**: Supabase (PostgreSQL)
* **HTTP Client**: `http` / `supabase_flutter`
* **Version Control**: Git & GitHub

---

## 🏗️ Struktur Arsitektur Aplikasi

Aplikasi ini menerapkan arsitektur berlapis sesuai standar penugasan:

```text
lib/
├── models/             # Data Models (CoffeeBean, BrewLog)
├── services/           # Network Services & Supabase Client
├── repositories/       # Data Access Layer / Abstraction
├── providers/          # Application State (BrewLogProvider, CoffeeProvider)
├── screens/            # UI Screens (Home, Catalog, Detail, AddEdit, MyLogs, Profile)
├── widgets/            # Reusable Widgets (CoffeeCard, CustomButton, Banner)
└── main.dart           # Application Entry Point & Provider Injection
🗄️ Struktur Tabel Database (Supabase)Aplikasi terhubung ke tabel user_brew_logs pada database Supabase dengan skema berikut:Nama KolomTipe DataDeskripsiidbigint (PK, Identity)ID unik catatancreated_attimestampWaktu pemuatan catatanbean_nametextNama biji kopiorigintextAsal daerah kopibrew_methodtextMetode penyeduhan (V60, Espresso, dll)grind_sizetextTingkat gilingan kopiratingnumericSkala rating rasa (1.0 - 5.0)personal_notetextCatatan personal profil rasa
📱 Panduan Menjalankan Project (Getting Started)Clone Repository:Bashgit clone [https://github.com/riuniversee/sidelake_roastery.git](https://github.com/riuniversee/sidelake_roastery.git)
cd sidelake_roastery
Install Dependensi:Bashflutter pub get
Konfigurasi Supabase:
Pastikan URL dan Anon Key Supabase sudah diset pada file lib/services/supabase_service.dart atau file environment.Jalankan Aplikasi:Bashflutter run
Build Release APK:Bashflutter build apk --release
📸 Screenshot Tampilan
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1d3a5786-336b-41f1-8b6c-940ac6f29d10" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b5e0dca4-7e2c-4b50-bf53-1f39b03ef963" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/35508531-8677-4d41-aac4-e58ed5c3665d" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/fcbb0149-22d7-4b21-962e-8d004cd59e2b" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1b271c66-57a6-452e-a8d1-569b5ac8d8e6" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/77866d5a-e292-4c86-abb7-17a098ec58c8" />






# sidelake_roastery

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
