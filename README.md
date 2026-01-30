# Colorn't 🎨

> Aplikasi bantuan visual berbasis AI untuk penyandang buta warna

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-FFCA28?logo=firebase)](https://firebase.google.com)
[![Gemini AI](https://img.shields.io/badge/Gemini-2.5%20Flash-4285F4?logo=google)](https://ai.google.dev)

---

## 🌈 Tentang Colorn't

**Colorn't** adalah aplikasi mobile yang membantu penyandang buta warna untuk mengenali dan memahami warna di sekitar mereka dengan lebih mudah. Menggunakan kekuatan **Large Language Model (LLM)** dari Google Gemini, Colorn't memberikan penjelasan warna yang natural dan kontekstual—seolah ada asisten pribadi yang membantu Anda "melihat" warna.

### 🎯 Latar Belakang

Buta warna (color vision deficiency) mempengaruhi sekitar **8% pria** dan **0.5% wanita** di seluruh dunia. Kondisi ini sering kali menjadi tantangan dalam aktivitas sehari-hari:

- Memilih pakaian yang matching
- Membedakan kabel elektronik berdasarkan warna
- Mengenali sinyal lampu lalu lintas
- Memahami visualisasi data berbasis warna
- Berinteraksi dengan lingkungan yang mengandalkan kode warna

Kebanyakan solusi yang ada hanya memberikan **nama warna teknis** (misal: "Merah RGB(255,0,0)") yang kurang membantu dalam konteks nyata.

### 💡 Solusi yang Kami Tawarkan

Colorn't menghadirkan pendekatan yang **lebih manusiawi**:

1. **Analisis Warna Berbasis AI**  
   Ambil foto objek, dan AI akan menjelaskan warna dalam bahasa yang mudah dipahami—termasuk konteks, posisi, dan perbedaan warna yang relevan.

2. **Kuis Interaktif**  
   Latih kemampuan penglihatan warna Anda melalui 3 jenis kuis yang dirancang khusus:
    - **Identifikasi Warna** – Tebak warna dari kotak yang ditampilkan
    - **Susun Gradasi** – Urutkan warna membentuk gradasi yang benar
    - **Cari yang Berbeda** – Temukan satu warna yang berbeda di antara warna mirip

3. **Riwayat Tersimpan**  
   Semua hasil analisis dan skor kuis tersimpan secara cloud, bisa diakses kapan saja.

---

## ✨ Fitur Utama

### 🔍 Analisis Warna dengan AI

- **Foto Langsung**: Ambil foto objek menggunakan kamera
- **Penjelasan Kontekstual**: AI menjelaskan warna utama, warna pendukung, letak objek, dan kontras warna
- **Simpan Riwayat**: Semua analisis tersimpan otomatis dengan gambar asli

**Contoh Output AI:**
> *"Di tengah gambar terdapat buah apel dengan warna merah terang yang dominan. Daun di bagian atas berwarna hijau tua, memberikan kontras yang cukup jelas dengan merah apelnya. Latar belakang berwarna putih kekuningan, memberikan kesan bersih."*

### 🎮 Kuis Warna Interaktif

**1. Identifikasi Warna**
- Tebak nama warna dari kotak yang ditampilkan
- 5 soal acak per sesi
- Pilihan ganda dengan 4 opsi

**2. Susun Gradasi Warna**
- Drag & drop warna untuk membentuk gradasi yang benar
- Uji sensitivitas terhadap perbedaan warna halus
- Skor berdasarkan akurasi urutan

**3. Cari yang Berbeda**
- Grid 5×5 dengan satu kotak berwarna berbeda
- Latih deteksi perbedaan warna minimal
- Tingkatkan sensitivitas penglihatan warna

### 📊 Riwayat Lengkap

- **Riwayat Analisis**: Lihat kembali foto dan hasil analisis sebelumnya
- **Riwayat Kuis**: Track progress, best score, dan akurasi dari setiap jenis kuis
- **Statistik Detail**: Jumlah permainan, tanggal terakhir main, peningkatan performa

---

## 🛠️ Teknologi yang Digunakan

### Frontend & Framework

- **Flutter 3.0+** – Cross-platform mobile framework
- **Dart** – Programming language
- **Provider** – State management

### Backend & Cloud Services

- **Firebase Auth** – Autentikasi pengguna
- **Cloud Firestore** – Database NoSQL untuk riwayat
- **Cloudinary** – Cloud storage untuk gambar analisis

### Artificial Intelligence

- **Google Gemini 2.5 Flash** – Large Language Model untuk analisis warna

### Libraries Utama
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  google_generative_ai: ^latest
  cloudinary_public: ^latest
  image_picker: ^latest
  provider: ^latest
  shared_preferences: ^latest
```

---

## 📱 Arsitektur Aplikasi

Colorn't dibangun dengan **Clean Architecture** dan **Feature-First Structure**:
```
lib/
├── core/                   # Komponen inti dan shared
│   ├── config/            # Konfigurasi app (API keys, Firebase)
│   ├── routes/            # Routing & navigation
│   ├── theme/             # App theme & styling
│   ├── utils/             # Helper & utilities
│   └── widgets/           # Reusable widgets
│
├── features/              # Fitur-fitur utama (feature-first)
│   ├── auth/             # Login & register
│   ├── onboarding/       # Onboarding screens
│   ├── analisisWarna/    # Analisis warna dengan AI
│   ├── kuisWarna/        # Kuis interaktif
│   │   ├── kuis1/       # Identifikasi warna
│   │   ├── kuis2/       # Susun gradasi
│   │   └── kuis3/       # Cari yang berbeda
│   ├── riwayat/         # Riwayat analisis & kuis
│   └── profile/         # Profil pengguna
│
└── services/             # Business logic & API calls
    ├── auth_service.dart
    ├── gemini_service.dart
    ├── analysis_history_service.dart
    └── quiz_history_service.dart
```

### Alur Data
```
┌─────────────┐
│    User     │
└──────┬──────┘
       │
       ▼
┌─────────────────┐
│   UI Layer      │  ← Widgets & Pages
│   (Feature)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Service Layer  │  ← Business Logic
│  (Provider)     │
└────────┬────────┘
         │
    ┌────┴────┐
    ▼         ▼
┌────────┐ ┌──────────┐
│Firebase│ │ Gemini   │
│  API   │ │   AI     │
└────────┘ └──────────┘
```

---

## 🚀 Cara Menjalankan Proyek

### Prerequisites

- Flutter SDK 3.0 atau lebih baru
- Dart SDK 2.17+
- Firebase project yang sudah dikonfigurasi
- Akun Cloudinary (untuk storage gambar)
- API Key Google Gemini

### Langkah Instalasi

1. **Clone repository**
```bash
   git clone https://github.com/username/colornt.git
   cd colornt
```

2. **Install dependencies**
```bash
   flutter pub get
```

3. **Setup Firebase**
    - Buat project Firebase di [Firebase Console](https://console.firebase.google.com)
    - Download `google-services.json` (Android)
    - Tempatkan di direktori yang sesuai
    - Jalankan:
```bash
     flutterfire configure
```

4. **Setup Environment Variables**  
   Buat file `.env` di root project:
```env
   GEMINI_API_KEY=your_gemini_api_key_here
   CLOUDINARY_CLOUD_NAME=your_cloudinary_cloud_name
   CLOUDINARY_UPLOAD_PRESET=your_upload_preset
```

5. **Update `pubspec.yaml`**  
   Pastikan `.env` sudah terdaftar:
```yaml
   flutter:
     assets:
       - .env
       - assets/images/
```

6. **Jalankan aplikasi**
```bash
   flutter run
```

---

## 🎨 Design System

### Color Palette

- **Primary**: `#00A8A8` (Teal)
- **Background**: `#FAFEFF` (Off-white)
- **Text Primary**: `#0D1B1E` (Dark)
- **Text Secondary**: `#64748B` (Gray)

### Typography

- **Font Family**: Plus Jakarta Sans
- **Heading**: Bold, 24-32px
- **Body**: Regular, 14-16px

---

## 🤝 Kontribusi

Kami sangat terbuka untuk kontribusi! Berikut cara berkontribusi:

1. **Fork** repository ini
2. Buat **branch** fitur baru (`git checkout -b feature/AmazingFeature`)
3. **Commit** perubahan (`git commit -m 'Add some AmazingFeature'`)
4. **Push** ke branch (`git push origin feature/AmazingFeature`)
5. Buat **Pull Request**

### Guidelines

- Ikuti arsitektur dan struktur folder yang ada
- Gunakan Bahasa Indonesia untuk komentar dan dokumentasi
- Pastikan kode sudah diformat (`flutter format .`)
- Test fitur sebelum submit PR

---

## 🙏 Acknowledgments

- [Google Gemini AI](https://ai.google.dev) untuk API analisis warna
- [Firebase](https://firebase.google.com) untuk backend infrastructure
- [Cloudinary](https://cloudinary.com) untuk image hosting
- Komunitas Flutter Indonesia

---

<div align="center">
  <p><i>"Warna bukan hanya yang kita lihat, tapi yang kita rasakan"</i></p>
</div>