import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

// Import konfigurasi Firebase
import 'firebase_options.dart';

// Import halaman
import 'home_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'tugas3_page.dart';

// Import provider
import 'theme_provider.dart';
import 'auth_provider.dart';

Future<void> main() async {
  // Wajib: inisialisasi Flutter dan Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Jalankan aplikasi dengan Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pantau state tema (terang/gelap)
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Tugas Flutter',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,

      // Tema terang
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
        useMaterial3: true,
      ),

      // Tema gelap
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),

      // Halaman awal otomatis tergantung login
      home: const AuthWrapper(),

      // Rute-rute aplikasi
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/tugas3': (context) => Tugas3Page(),
      },
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET PENTING: AuthWrapper
// Mengecek apakah user sudah login, dan mengarahkan ke halaman yang sesuai.
// -----------------------------------------------------------------------------
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        // Jika user tidak null -> sudah login
        if (user != null) {
          return const HomePage();
        }
        // Jika belum login -> tampilkan halaman login
        return const LoginPage();
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(
          child: Text('Terjadi error: $error'),
        ),
      ),
    );
  }
}
