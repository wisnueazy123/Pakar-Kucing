import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bantuan_screen.dart';
import 'hubungi_ahli_screen.dart';
import 'info_penyakit_screen.dart';
import 'konsultasi_screen.dart';

/// Halaman menu utama aplikasi.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _konfirmasiKeluar(BuildContext context) async {
    final bool? keluar = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Konfirmasi Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
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

    if (keluar != true) {
      return;
    }

    if (kIsWeb) {
      // Pada FlutLab (web) tab browser tidak bisa ditutup dari kode,
      // sehingga dialog konfirmasi cukup ditutup tanpa aksi tambahan.
      return;
    }

    await SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final List<_MenuHome> daftarMenu = <_MenuHome>[
      _MenuHome(
        label: 'Info Penyakit',
        icon: Icons.list_alt,
        warna: Colors.blue,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const InfoPenyakitScreen(),
            ),
          );
        },
      ),
      _MenuHome(
        label: 'Pendeteksi Penyakit',
        icon: Icons.check_circle,
        warna: Colors.green,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const KonsultasiScreen(),
            ),
          );
        },
      ),
      _MenuHome(
        label: 'Bantuan',
        icon: Icons.help,
        warna: Colors.amber.shade700,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const BantuanScreen(),
            ),
          );
        },
      ),
      _MenuHome(
        label: 'Hubungi Ahli',
        icon: Icons.person,
        warna: Colors.grey,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const HubungiAhliScreen(),
            ),
          );
        },
      ),
      _MenuHome(
        label: 'Keluar',
        icon: Icons.close,
        warna: Colors.red,
        onTap: () => _konfirmasiKeluar(context),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakar Kucing'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Selamat Datang di Pakar Kucing',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pilih menu di bawah ini untuk memulai.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: daftarMenu.map(_kartuMenu).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kartuMenu(_MenuHome menu) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: menu.onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                menu.icon,
                size: 50,
                color: menu.warna,
              ),
              const SizedBox(height: 12),
              Flexible(
                child: Text(
                  menu.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Data satu menu pada halaman utama.
class _MenuHome {
  const _MenuHome({
    required this.label,
    required this.icon,
    required this.warna,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color warna;
  final VoidCallback onTap;
}
