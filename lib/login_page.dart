import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.flutter_dash, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  final user = ref.read(registeredUserProvider);
                  if (user != null &&
                      user.email == emailController.text &&
                      user.password == passwordController.text) {
                    // login sukses
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  } else {
                    // login gagal
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Email atau password salah!")),
                    );
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: const Text("Belum punya akun? Daftar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
