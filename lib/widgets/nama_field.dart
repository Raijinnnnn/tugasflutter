import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

class NamaField extends ConsumerWidget {
  final String nama;

  const NamaField({super.key, required this.nama});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Nama",
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (value) {
        ref.read(namaProvider.notifier).state = value;
      },
    );
  }
}
