import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 Register akun baru
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // 🔹 (Opsional) Simpan data profil user ke Firestore
  Future<void> saveUserProfile(String uid, String name) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 🔹 Login
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // 🔹 Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 🔹 Dapatkan user saat ini
  User? get currentUser => _auth.currentUser;

  // 🔹 Stream perubahan status login
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}

// Provider untuk AuthService
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Provider untuk pantau status login
final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authServiceProvider).authStateChanges(),
);
