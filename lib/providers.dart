import 'package:flutter_riverpod/flutter_riverpod.dart';

// counter provider
final counterProvider = StateProvider<int>((ref) => 0);

// notif provider
final notifProvider = StateProvider<bool>((ref) => false);

// nama provider
final namaProvider = StateProvider<String>((ref) => "");
