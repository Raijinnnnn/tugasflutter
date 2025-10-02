import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'login_page.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text("Register", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama Lengkap"),
              ),
              const SizedBox(height: 12),
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
                  // Simpan user ke provider
                  ref.read(registeredUserProvider.notifier).state = User(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Registrasi berhasil! Silakan login.")),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: const Text("Daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
