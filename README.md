# Multi Deploy Automation Script

Script ini digunakan untuk melakukan **multiple deployment** secara otomatis dengan menggandakan folder, serta mengganti isi file tertentu berdasarkan daftar yang telah ditentukan.

## 📁 Struktur File

```
project-root/
├── project.pkm.com (referensi project)
├── deploy-list.txt
├── file-list.txt
├── deploy-multiple.bat (script ini)
└── result/ (folder hasil generate)
```

## 📄 Penjelasan File

- `deploy.bat`: Script utama yang menjalankan proses deployment untuk setiap baris di `deploy-list.txt`.
- `deploy-list.txt`: Daftar konfigurasi deployment. Setiap baris berformat:
  ```
  old_folder|new_folder|old_db|new_db|old_code|new_code
  ```
  Contoh:
  ```
  template|puskesmas-aceh|db_template|db_aceh|KODE123|KODEACEH
  ```
- `file-list.txt`: Daftar relatif path file dalam folder hasil clone (`result/...`) yang perlu diganti kontennya.
  Contoh:
  ```
  src/environments/environment.prod.ts
  README.md
  ```

## ⚙️ Cara Kerja Script

1. Script membaca setiap baris dari `deploy-list.txt`.
2. Untuk setiap baris:
   - Folder `old_folder` akan disalin ke `result/new_folder`.
   - File dalam daftar `file-list.txt` akan diproses:
     - Semua teks `old_db` akan diganti dengan `new_db`.
     - Semua teks `old_code` akan diganti dengan `new_code`.
3. Proses ini diulang untuk semua baris.

## ✅ Contoh Output

Jika `deploy-list.txt` berisi:

```
template|puskesmas-aceh|db_template|db_aceh|KODE123|KODEACEH
template|puskesmas-medan|db_template|db_medan|KODE123|KODEMEDAN
```

Maka hasilnya:

```
result/
├── puskesmas-aceh/
│   └── clenic/
│       └── semua file dengan database dan kode sudah diganti
├── puskesmas-medan/
│   └── clenic/
│       └── semua file dengan database dan kode sudah diganti
```

## 📺 Requirement

- Windows OS
- PowerShell (untuk operasi replace di file)

## 📝 Catatan

- Pastikan file dan folder tidak mengandung karakter aneh atau spasi ekstra.
- Jika ada file yang tidak ditemukan saat proses replace, akan ditampilkan pesan peringatan.

## 🚀 Menjalankan Script

Cukup klik dua kali `deploy.bat` atau jalankan lewat terminal:

```bash
deploy.bat
```

---

Happy Deploying! 🎉
