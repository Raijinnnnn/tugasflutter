import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ===================
/// User Model & Auth
/// ===================
class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});
}

final registeredUserProvider = StateProvider<User?>((ref) => null);
final currentUserProvider = StateProvider<User?>((ref) => null);

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier(this.ref) : super(null);
  final Ref ref;

  void register(String name, String email, String password) {
    final newUser = User(name: name, email: email, password: password);
    ref.read(registeredUserProvider.notifier).state = newUser;
  }

  bool login(String email, String password) {
    final registeredUser = ref.read(registeredUserProvider);
    if (registeredUser != null &&
        registeredUser.email == email &&
        registeredUser.password == password) {
      state = registeredUser;
      return true;
    }
    return false;
  }

  void logout() {
    state = null;
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, User?>((ref) => AuthNotifier(ref));