import 'package:flutter/material.dart';

import '../data/data_penyakit.dart';
import '../models/penyakit.dart';
import 'detail_penyakit_screen.dart';

/// Halaman daftar penyakit yang dikenali sistem pakar.
class InfoPenyakitScreen extends StatelessWidget {
  const InfoPenyakitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Penyakit'),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: daftarPenyakit.length,
          itemBuilder: (BuildContext context, int index) {
            final Penyakit penyakit = daftarPenyakit[index];

            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          DetailPenyakitScreen(penyakit: penyakit),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4A373),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              penyakit.kode,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              penyakit.nama,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        penyakit.deskripsi,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
