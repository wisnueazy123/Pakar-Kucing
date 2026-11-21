# Pakar Kucing — Sistem Pakar Diagnosa Penyakit Kucing

Aplikasi Flutter (Android/Web) dengan metode **Forward Chaining**, 18 gejala,
5 penyakit, dan 5 rule. Semua data hardcoded, tanpa package eksternal
(hanya `flutter` + `cupertino_icons`), tanpa `dart:io`, tanpa HTTP.

## Struktur

```
pubspec.yaml
lib/main.dart
lib/models/penyakit.dart
lib/models/gejala.dart
lib/models/rule.dart
lib/data/data_penyakit.dart
lib/data/data_gejala.dart
lib/data/rule_base.dart
lib/screens/splash_screen.dart
lib/screens/home_screen.dart
lib/screens/info_penyakit_screen.dart
lib/screens/detail_penyakit_screen.dart
lib/screens/konsultasi_screen.dart
lib/screens/hasil_screen.dart
lib/screens/bantuan_screen.dart
lib/screens/hubungi_ahli_screen.dart
```

## Cara memasukkan ke FlutLab

1. Buka project di https://flutlab.io (editor yang Anda miliki).
2. Buka `pubspec.yaml`, ganti seluruh isinya dengan isi `pubspec.yaml` di folder ini.
3. Di panel file, buat folder: `lib/models`, `lib/data`, `lib/screens`.
4. Buat setiap file dengan nama yang sama, lalu salin isinya dari folder ini.
5. Tekan **Run** / **Build**. Tidak perlu `flutter pub get` manual karena
   dependency hanya `flutter` dan `cupertino_icons`.
6. Jika `cupertino_icons: ^1.0.6` gagal resolve di editor, ubah menjadi
   `cupertino_icons: ^1.0.2`.

Catatan FlutLab (web): menu **Keluar** hanya menampilkan dialog konfirmasi.
Tab browser tidak ditutup dari kode (memang disengaja agar editor FlutLab
tidak ikut tertutup). Di Android, aplikasi akan benar-benar keluar.

## Logika Forward Chaining

`lib/data/rule_base.dart` → `forwardChaining(Map<String, bool> jawaban)`:

1. Kumpulkan kode gejala yang dijawab **Ya** menjadi himpunan fakta.
2. Telusuri R1–R5.
3. Rule terpenuhi hanya jika **semua** gejala premis ada di fakta.
4. Tambahkan penyakit kesimpulan (tanpa duplikasi).
5. Jika tidak ada rule cocok → list kosong → layar hasil menampilkan
   "Penyakit Tidak Terdeteksi".

## Menjalankan lokal

```bash
flutter pub get
flutter analyze
flutter run
```
