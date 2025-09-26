import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

class NotifSwitch extends ConsumerWidget {
  final bool notifOn;

  const NotifSwitch({super.key, required this.notifOn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Switch(
      value: notifOn,
      onChanged: (value) {
        ref.read(notifProvider.notifier).state = value;
      },
    );
  }
}
