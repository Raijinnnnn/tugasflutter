import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme_provider.dart'; // <-- Import ini sudah benar

// Ganti nama class-nya agar sesuai dengan nama file
class CounterButton extends ConsumerWidget {
  const CounterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- PERBAIKAN LOGIKA DI SINI ---

    // 1. Ambil ThemeMode (bukan bool)
    final themeMode = ref.watch(themeProvider);

    // 2. Cek apakah themeMode-nya adalah .dark
    final isDark = themeMode == ThemeMode.dark;

    // --- AKHIR PERBAIKAN ---

    return FloatingActionButton(
      onPressed: () {
        // 3. Ganti state-nya ke nilai ThemeMode yang berlawanan
        ref.read(themeProvider.notifier).state =
            isDark ? ThemeMode.light : ThemeMode.dark;
      },
      child: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
      ),
    );
  }
}
