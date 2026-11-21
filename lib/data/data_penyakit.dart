import '../models/penyakit.dart';

/// Daftar penyakit yang dikenali oleh sistem pakar.
const List<Penyakit> daftarPenyakit = <Penyakit>[
  Penyakit(
    kode: 'P1',
    nama: 'Scabies',
    deskripsi:
        'Penyakit kulit menular pada kucing yang disebabkan tungau Sarcoptes scabiei. Menyebabkan gatal hebat, kerak, dan bulu rontok.',
    solusi:
        'Mandikan dengan sampo anti-tungau, berikan obat ivermectin sesuai resep dokter hewan, isolasi kucing dari hewan lain, bersihkan kandang.',
  ),
  Penyakit(
    kode: 'P2',
    nama: 'Otitis',
    deskripsi:
        'Peradangan pada saluran telinga kucing, biasanya akibat infeksi bakteri, jamur, atau tungau. Menyebabkan telinga berbau, gatal, dan kepala miring.',
    solusi:
        'Bersihkan telinga dengan cairan pembersih khusus, berikan obat tetes telinga dari dokter hewan, hindari air masuk ke telinga.',
  ),
  Penyakit(
    kode: 'P3',
    nama: 'Cacingan',
    deskripsi:
        'Infeksi cacing parasit pada saluran pencernaan kucing. Menyebabkan perut buncit, diare, dan berat badan turun meski makan banyak.',
    solusi:
        'Berikan obat cacing sesuai dosis dokter hewan, jaga kebersihan makanan dan tempat makan, lakukan deworming rutin 3 bulan sekali.',
  ),
  Penyakit(
    kode: 'P4',
    nama: 'Ringworm',
    deskripsi:
        'Infeksi jamur dermatofita pada kulit kucing. Menyebabkan kebotakan berbentuk lingkaran, gatal, dan kulit bersisik.',
    solusi:
        'Berikan obat anti-jamur oral/topikal dari dokter hewan, mandikan dengan sampo anti-jamur, jaga kandang tetap kering, isolasi kucing.',
  ),
  Penyakit(
    kode: 'P5',
    nama: 'Rabies',
    deskripsi:
        'Penyakit virus mematikan yang menyerang sistem saraf. Menyebabkan agresif, sensitif, takut air, dan kematian. Berbahaya bagi manusia.',
    solusi:
        'SEGERA bawa ke dokter hewan, lakukan vaksinasi rabies rutin, hindari kontak dengan kucing liar, jika ada gigitan segera ke RS.',
  ),
];

/// Mencari data penyakit berdasarkan kode (contoh: "P1").
///
/// Mengembalikan null bila kode tidak ditemukan.
Penyakit? penyakitByKode(String kode) {
  for (final Penyakit penyakit in daftarPenyakit) {
    if (penyakit.kode == kode) {
      return penyakit;
    }
  }
  return null;
}
