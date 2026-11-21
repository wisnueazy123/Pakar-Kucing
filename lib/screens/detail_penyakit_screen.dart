import 'package:flutter/material.dart';

import '../data/data_gejala.dart';
import '../data/rule_base.dart';
import '../models/gejala.dart';
import '../models/penyakit.dart';
import '../models/rule.dart';

/// Halaman detail satu penyakit beserta gejala dan solusinya.
class DetailPenyakitScreen extends StatelessWidget {
  const DetailPenyakitScreen({
    super.key,
    required this.penyakit,
  });

  final Penyakit penyakit;

  /// Mengambil daftar gejala yang menjadi premis rule untuk penyakit ini.
  List<Gejala> _gejalaTerkait() {
    final Set<String> kodeGejala = <String>{};
    for (final Rule rule in daftarRule) {
      if (rule.kodePenyakit == penyakit.kode) {
        kodeGejala.addAll(rule.gejala);
      }
    }

    final List<Gejala> hasil = <Gejala>[];
    for (final String kode in kodeGejala) {
      final Gejala? gejala = gejalaByKode(kode);
      if (gejala != null) {
        hasil.add(gejala);
      }
    }
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    final List<Gejala> gejalaTerkait = _gejalaTerkait();

    return Scaffold(
      appBar: AppBar(
        title: Text(penyakit.nama),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
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
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A373),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        penyakit.kode,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        penyakit.nama,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _kartuBagian(
                judul: 'Deskripsi',
                icon: Icons.description,
                anak: Text(
                  penyakit.deskripsi,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
              _kartuBagian(
                judul: 'Solusi',
                icon: Icons.healing,
                anak: Text(
                  penyakit.solusi,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
              _kartuBagian(
                judul: 'Gejala Terkait',
                icon: Icons.pets,
                anak: gejalaTerkait.isEmpty
                    ? const Text(
                        'Belum ada data gejala untuk penyakit ini.',
                        style: TextStyle(color: Colors.black54),
                      )
                    : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: gejalaTerkait.map((Gejala gejala) {
                          return Chip(
                            backgroundColor: const Color(0xFFF5E6D3),
                            label: Text('${gejala.kode} - ${gejala.nama}'),
                            labelStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kartuBagian({
    required String judul,
    required IconData icon,
    required Widget anak,
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
          anak,
        ],
      ),
    );
  }
}
