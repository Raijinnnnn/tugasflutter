import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_provider.dart'; // Menggunakan theme_provider yang sudah ada
import 'auth_provider.dart'; // <-- TAMBAHKAN IMPORT INI

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memantau status tema (terang/gelap) dari provider
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selamat Datang!"),
        actions: [
          // Tombol untuk mengganti mode tema
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              // Mengubah state pada themeProvider
              ref.read(themeProvider.notifier).state =
                  isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          // Tombol menu untuk logout dan info
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // --- PERUBAHAN DI SINI ---
                // Panggil fungsi signOut dari provider Firebase
                ref.read(authServiceProvider).signOut();
                // Kita tidak perlu navigasi manual lagi,
                // AuthWrapper akan menangani perpindahan halaman otomatis
                // --- AKHIR PERUBAHAN ---
              } else if (value == 'info') {
                showAboutDialog(
                    context: context,
                    applicationName: 'Tugas Flutter',
                    applicationVersion: '1.0.1',
                    children: [
                      const Text(
                          'Aplikasi ini dibuat untuk memenuhi tugas mata kuliah Pemrograman Mobile.'),
                    ]);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'info',
                child: Text('Tentang Aplikasi'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          // Menggunakan SingleChildScrollView agar bisa di-scroll jika tombolnya banyak
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon besar sebagai hiasan
                Icon(
                  Icons.storefront_outlined,
                  size: 100,
                  color: Colors.deepPurple.shade300,
                ),
                const SizedBox(height: 20),
                // Teks sambutan
                const Text(
                  'Selamat Datang di Toko Segar',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Temukan buah, sayur, dan kebutuhan segar lainnya di sini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 40),
                // Tombol untuk navigasi ke halaman produk
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigasi ke halaman Tugas 3 dimana produk ditampilkan
                    Navigator.pushNamed(context, '/tugas3');
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Lihat Semua Produk'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

