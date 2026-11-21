import '../models/penyakit.dart';
import '../models/rule.dart';
import 'data_penyakit.dart';

/// Basis aturan (rule base) untuk metode Forward Chaining.
///
/// R1: IF G1 AND G2 AND G3 AND G4 THEN P1 (Scabies)
/// R2: IF G5 AND G6 AND G7 AND G8 THEN P2 (Otitis)
/// R3: IF G9 AND G10 AND G11 AND G12 AND G17 THEN P3 (Cacingan)
/// R4: IF G1 AND G13 AND G14 THEN P4 (Ringworm)
/// R5: IF G15 AND G16 AND G18 THEN P5 (Rabies)
const List<Rule> daftarRule = <Rule>[
  Rule(
    kode: 'R1',
    gejala: <String>['G1', 'G2', 'G3', 'G4'],
    kodePenyakit: 'P1',
  ),
  Rule(
    kode: 'R2',
    gejala: <String>['G5', 'G6', 'G7', 'G8'],
    kodePenyakit: 'P2',
  ),
  Rule(
    kode: 'R3',
    gejala: <String>['G9', 'G10', 'G11', 'G12', 'G17'],
    kodePenyakit: 'P3',
  ),
  Rule(
    kode: 'R4',
    gejala: <String>['G1', 'G13', 'G14'],
    kodePenyakit: 'P4',
  ),
  Rule(
    kode: 'R5',
    gejala: <String>['G15', 'G16', 'G18'],
    kodePenyakit: 'P5',
  ),
];

/// Mesin inferensi Forward Chaining.
///
/// Logika pencocokan rule:
/// 1. Ambil seluruh kode gejala yang dijawab "Ya" sebagai fakta awal.
/// 2. Telusuri rule satu per satu (R1 sampai R5).
/// 3. Rule dianggap terpenuhi HANYA jika SEMUA gejala pada premisnya ada
///    di dalam daftar fakta (penalaran maju / data driven).
/// 4. Jika terpenuhi, kesimpulan rule (penyakit) ditambahkan ke hasil.
/// 5. Jika tidak ada rule yang terpenuhi, hasil berupa list kosong sehingga
///    aplikasi menampilkan pesan "penyakit tidak terdeteksi".
List<Penyakit> forwardChaining(Map<String, bool> jawaban) {
  // Langkah 1: kumpulkan fakta dari jawaban pengguna.
  final Set<String> fakta = <String>{};
  jawaban.forEach((String kode, bool nilai) {
    if (nilai) {
      fakta.add(kode);
    }
  });

  // Langkah 2-4: cocokkan setiap rule dengan fakta yang ada.
  final List<Penyakit> hasil = <Penyakit>[];
  for (final Rule rule in daftarRule) {
    final bool semuaGejalaTerpenuhi = rule.gejala.every(fakta.contains);
    if (!semuaGejalaTerpenuhi) {
      continue;
    }

    final Penyakit? penyakit = penyakitByKode(rule.kodePenyakit);
    if (penyakit == null) {
      continue;
    }

    // Hindari duplikasi bila lebih dari satu rule menghasilkan penyakit sama.
    final bool sudahAda = hasil.any(
      (Penyakit item) => item.kode == penyakit.kode,
    );
    if (!sudahAda) {
      hasil.add(penyakit);
    }
  }

  return hasil;
}
