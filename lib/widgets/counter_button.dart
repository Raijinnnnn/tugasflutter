import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

class CounterButton extends ConsumerWidget {
  final int counter;

  const CounterButton({super.key, required this.counter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(counterProvider.notifier).state++;
      },
      child: Text('$counter'),
    );
  }
}
