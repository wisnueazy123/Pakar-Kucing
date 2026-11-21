import 'package:flutter/material.dart';

/// Halaman bantuan berisi panduan, penjelasan metode, dan tips.
class BantuanScreen extends StatelessWidget {
  const BantuanScreen({super.key});

  static const List<_ItemBantuan> _daftarBantuan = <_ItemBantuan>[
    _ItemBantuan(
      icon: Icons.touch_app,
      warna: Colors.blue,
      judul: 'Cara Pakai',
      isi: '1. Pilih menu Pendeteksi Penyakit pada halaman utama.\n'
          '2. Jawab setiap pertanyaan gejala dengan tombol YA atau TIDAK '
          'sesuai kondisi kucing Anda.\n'
          '3. Setelah 18 pertanyaan selesai dijawab, sistem akan menampilkan '
          'hasil diagnosis beserta deskripsi dan solusinya.\n'
          '4. Gunakan tombol Konsultasi Ulang untuk memulai pendeteksian baru.',
    ),
    _ItemBantuan(
      icon: Icons.account_tree,
      warna: Colors.green,
      judul: 'Tentang Forward Chaining',
      isi: 'Forward Chaining adalah metode penalaran yang dimulai dari fakta '
          '(gejala yang dipilih pengguna), lalu mencari aturan (rule) yang '
          'cocok. Jika seluruh gejala pada premis sebuah rule terpenuhi, '
          'maka kesimpulan berupa penyakit akan dihasilkan. Karena bergerak '
          'dari data menuju kesimpulan, metode ini disebut juga penalaran '
          'maju (data driven).',
    ),
    _ItemBantuan(
      icon: Icons.favorite,
      warna: Colors.red,
      judul: 'Tips Kesehatan Kucing',
      isi: '• Lakukan vaksinasi rutin sesuai jadwal dari dokter hewan.\n'
          '• Beri makanan bergizi dan air minum bersih setiap hari.\n'
          '• Jaga kebersihan kandang, tempat makan, dan tempat minum.\n'
          '• Mandikan kucing secara teratur dan periksa bulu serta kulitnya.\n'
          '• Lakukan pemeriksaan kesehatan berkala ke dokter hewan.',
    ),
    _ItemBantuan(
      icon: Icons.warning_amber_rounded,
      warna: Colors.orange,
      judul: 'Peringatan',
      isi: 'Aplikasi ini hanya memberikan diagnosis awal berdasarkan gejala '
          'yang Anda masukkan. Hasil diagnosis bukan pengganti pemeriksaan '
          'dokter hewan. Selalu konsultasikan kondisi kucing Anda kepada '
          'dokter hewan untuk penanganan yang tepat.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuan'),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _daftarBantuan.length,
          itemBuilder: (BuildContext context, int index) {
            final _ItemBantuan item = _daftarBantuan[index];

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
                        item.icon,
                        color: item.warna,
                        size: 26,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.judul,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.isi,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Data satu kartu bantuan.
class _ItemBantuan {
  const _ItemBantuan({
    required this.icon,
    required this.warna,
    required this.judul,
    required this.isi,
  });

  final IconData icon;
  final Color warna;
  final String judul;
  final String isi;
}
