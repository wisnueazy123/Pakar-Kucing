/// Model data untuk satu gejala penyakit kucing.
class Gejala {
  const Gejala({
    required this.kode,
    required this.nama,
  });

  /// Kode gejala, contoh: "G1".
  final String kode;

  /// Nama / keterangan gejala yang ditampilkan ke pengguna.
  final String nama;
}
