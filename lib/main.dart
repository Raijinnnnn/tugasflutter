import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'theme_provider.dart'; // 🔥 tambahin import ini

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🔥 sekarang ambil ThemeMode dari provider
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 2 Flutter',

      // Light Mode
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
      ),

      // Dark Mode
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
      ),

      // 🔥 Aktifkan toggle dark/light dari provider
      themeMode: themeMode,

      // Pertama kali buka aplikasi → ke LoginPage
      home: const LoginPage(),

      // Routes
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}