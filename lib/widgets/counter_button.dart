import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_provider.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return FloatingActionButton(
      onPressed: () {
        ref.read(themeProvider.notifier).state = !isDark;
      },
      child: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
      ),
    );
  }
}