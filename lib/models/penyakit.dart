/// Model data untuk satu penyakit kucing.
class Penyakit {
  const Penyakit({
    required this.kode,
    required this.nama,
    required this.deskripsi,
    required this.solusi,
  });

  /// Kode penyakit, contoh: "P1".
  final String kode;

  /// Nama penyakit.
  final String nama;

  /// Penjelasan lengkap tentang penyakit.
  final String deskripsi;

  /// Solusi / penanganan yang disarankan.
  final String solusi;
}
