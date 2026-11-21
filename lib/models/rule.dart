/// Model aturan (rule) pada metode Forward Chaining.
///
/// Bentuk rule: IF gejala1 AND gejala2 AND ... THEN penyakit.
class Rule {
  const Rule({
    required this.kode,
    required this.gejala,
    required this.kodePenyakit,
  });

  /// Kode rule, contoh: "R1".
  final String kode;

  /// Daftar kode gejala sebagai premis (semua harus terpenuhi).
  final List<String> gejala;

  /// Kode penyakit sebagai kesimpulan rule.
  final String kodePenyakit;
}
