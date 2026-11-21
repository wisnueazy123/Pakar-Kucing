import '../models/gejala.dart';

/// Daftar 18 gejala yang digunakan pada proses konsultasi.
const List<Gejala> daftarGejala = <Gejala>[
  Gejala(kode: 'G1', nama: 'Bulu rontok hingga botak'),
  Gejala(kode: 'G2', nama: 'Kerak di sekitar telinga'),
  Gejala(kode: 'G3', nama: 'Kulit bersisik'),
  Gejala(kode: 'G4', nama: 'Gatal di sekitar telinga'),
  Gejala(kode: 'G5', nama: 'Sering menggelengkan kepala'),
  Gejala(kode: 'G6', nama: 'Menggaruk telinga hingga luka'),
  Gejala(kode: 'G7', nama: 'Cairan di telinga berbau tak sedap'),
  Gejala(kode: 'G8', nama: 'Kepala miring tidak bisa berjalan lurus'),
  Gejala(kode: 'G9', nama: 'Kurus tapi perut buncit'),
  Gejala(kode: 'G10', nama: 'Diare'),
  Gejala(kode: 'G11', nama: 'Ada cacing pada kotoran atau saat muntah'),
  Gejala(kode: 'G12', nama: 'Kebotakan berbentuk lingkaran'),
  Gejala(kode: 'G13', nama: 'Sering menggaruk badan'),
  Gejala(kode: 'G14', nama: 'Agresif'),
  Gejala(kode: 'G15', nama: 'Sensitif'),
  Gejala(kode: 'G16', nama: 'Tidak nafsu makan'),
  Gejala(kode: 'G17', nama: 'Gelisah'),
  Gejala(kode: 'G18', nama: 'Badan lemah'),
];

/// Mencari data gejala berdasarkan kode (contoh: "G1").
///
/// Mengembalikan null bila kode tidak ditemukan.
Gejala? gejalaByKode(String kode) {
  for (final Gejala gejala in daftarGejala) {
    if (gejala.kode == kode) {
      return gejala;
    }
  }
  return null;
}
