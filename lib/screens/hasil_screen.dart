import 'package:flutter/material.dart';

import '../models/gejala.dart';
import '../models/penyakit.dart';
import 'home_screen.dart';
import 'konsultasi_screen.dart';

/// Halaman hasil diagnosis dari proses Forward Chaining.
class HasilScreen extends StatelessWidget {
  const HasilScreen({
    super.key,
    required this.daftarPenyakit,
    required this.gejalaTerpilih,
  });

  /// Penyakit yang berhasil terdeteksi (bisa lebih dari satu).
  final List<Penyakit> daftarPenyakit;

  /// Gejala yang dijawab "Ya" oleh pengguna.
  final List<Gejala> gejalaTerpilih;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Diagnosis'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            ...daftarPenyakit.isEmpty
                ? <Widget>[_kartuTidakTerdeteksi()]
                : _kartuHasil(),
            _kartuGejalaTerpilih(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5E3C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => const KonsultasiScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Konsultasi Ulang'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF8B5E3C),
                  side: const BorderSide(
                    color: Color(0xFF8B5E3C),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (_) => const HomeScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.home),
                label: const Text('Kembali ke Menu'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Kartu hijau untuk setiap penyakit yang terdeteksi.
  List<Widget> _kartuHasil() {
    final List<Widget> widgets = <Widget>[];

    for (int i = 0; i < daftarPenyakit.length; i++) {
      final Penyakit penyakit = daftarPenyakit[i];

      widgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.verified,
                color: Colors.white,
                size: 34,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      daftarPenyakit.length > 1
                          ? 'Penyakit Terdeteksi (${i + 1} dari ${daftarPenyakit.length})'
                          : 'Penyakit Terdeteksi',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      penyakit.nama,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      widgets.add(
        _kartuBagian(
          judul: 'Deskripsi',
          icon: Icons.description,
          isi: penyakit.deskripsi,
        ),
      );
      widgets.add(
        _kartuBagian(
          judul: 'Solusi',
          icon: Icons.healing,
          isi: penyakit.solusi,
        ),
      );
    }

    return widgets;
  }

  Widget _kartuBagian({
    required String judul,
    required IconData icon,
    required String isi,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: const Color(0xFF8B5E3C),
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5E3C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            isi,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kartuTidakTerdeteksi() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red.shade700,
                size: 34,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Penyakit Tidak Terdeteksi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Maaf, berdasarkan gejala yang Anda pilih, sistem tidak menemukan '
            'penyakit yang cocok. Penyakit tidak terdeteksi, silakan konsultasi '
            'ke dokter hewan untuk pemeriksaan lebih lanjut.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kartuGejalaTerpilih() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.fact_check,
                color: Color(0xFF8B5E3C),
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Gejala yang Anda Pilih (${gejalaTerpilih.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5E3C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (gejalaTerpilih.isEmpty)
            const Text(
              'Tidak ada gejala yang dipilih.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: gejalaTerpilih.map((Gejala gejala) {
                return Chip(
                  backgroundColor: const Color(0xFFF5E6D3),
                  avatar: const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.green,
                  ),
                  label: Text('${gejala.kode} - ${gejala.nama}'),
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
