import 'package:flutter/material.dart';

import '../data/data_gejala.dart';
import '../data/rule_base.dart';
import '../models/gejala.dart';
import '../models/penyakit.dart';
import 'hasil_screen.dart';

/// Halaman konsultasi (pendeteksi penyakit) dengan pertanyaan Ya/Tidak.
class KonsultasiScreen extends StatefulWidget {
  const KonsultasiScreen({super.key});

  @override
  State<KonsultasiScreen> createState() => _KonsultasiScreenState();
}

class _KonsultasiScreenState extends State<KonsultasiScreen> {
  int _currentIndex = 0;
  final Map<String, bool> _jawaban = <String, bool>{};

  Gejala get _gejalaSekarang => daftarGejala[_currentIndex];

  void _jawab(bool nilai) {
    _jawaban[_gejalaSekarang.kode] = nilai;

    // Jika ini pertanyaan terakhir, langsung proses forward chaining.
    if (_currentIndex >= daftarGejala.length - 1) {
      _selesaikanKonsultasi();
      return;
    }

    setState(() {
      _currentIndex++;
    });
  }

  void _selesaikanKonsultasi() {
    // Jalankan mesin inferensi Forward Chaining berdasarkan jawaban pengguna.
    final List<Penyakit> hasil = forwardChaining(_jawaban);

    final List<Gejala> gejalaTerpilih = <Gejala>[];
    for (final Gejala gejala in daftarGejala) {
      if (_jawaban[gejala.kode] == true) {
        gejalaTerpilih.add(gejala);
      }
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => HasilScreen(
          daftarPenyakit: hasil,
          gejalaTerpilih: gejalaTerpilih,
        ),
      ),
    );
  }

  void _mulaiUlang() {
    setState(() {
      _currentIndex = 0;
      _jawaban.clear();
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Pendeteksian dimulai ulang dari pertanyaan pertama.'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
  }

  Future<void> _konfirmasiKembali() async {
    final bool? keluar = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Keluar dari Pendeteksian?'),
          content: const Text(
            'Jawaban yang sudah dipilih akan dihapus. '
            'Apakah Anda ingin kembali ke menu utama?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );

    if (keluar == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int total = daftarGejala.length;
    final double progress = (_currentIndex + 1) / total;
    final Gejala gejala = _gejalaSekarang;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendeteksi Penyakit'),
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back),
          onPressed: _konfirmasiKembali,
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Mulai ulang',
            icon: const Icon(Icons.refresh),
            onPressed: _mulaiUlang,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pertanyaan ${_currentIndex + 1} dari $total',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B5E3C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 12,
                  backgroundColor: Colors.white,
                  color: const Color(0xFF8B5E3C),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.pets,
                            size: 100,
                            color: Color(0xFFD4A373),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5E6D3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Gejala ${gejala.kode}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B5E3C),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            gejala.nama,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Apakah kucing Anda mengalami gejala ini?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _jawab(true),
                      icon: const Icon(Icons.check),
                      label: const Text(
                        'YA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _jawab(false),
                      icon: const Icon(Icons.close),
                      label: const Text(
                        'TIDAK',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
