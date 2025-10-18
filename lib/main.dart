import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'theme_provider.dart';
import 'tugas3_page.dart';

void main() {
  // ProviderScope adalah widget dari Riverpod yang menyimpan state dari semua provider.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memantau perubahan tema (terang/gelap)
    final themeMode = ref.watch(themeProvider);
    // Memantau status otentikasi pengguna
    final authState = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Flutter',

      // --- Pengaturan Tema ---
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeMode,

      // --- PERBAIKAN 1: Logika Halaman Awal ---
      // Mengecek apakah authState (objek User) tidak null.
      // Jika tidak null, berarti pengguna sudah login.
      home: authState != null ? const HomePage() : const LoginPage(),

      // --- Pengaturan Rute (Routes) ---
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        // --- PERBAIKAN 2: Constructor Widget ---
        // Menambahkan 'const' kembali karena ini adalah praktik terbaik untuk widget
        // yang tidak berubah. Error sebelumnya terjadi karena 'const' ada di Map, bukan di sini.
        '/tugas3': (context) => const Tugas3Page(),
      },
    );
  }
}

