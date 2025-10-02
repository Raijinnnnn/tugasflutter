import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider untuk counter (angka)
final counterProvider = StateProvider<int>((ref) => 0);

/// Provider untuk toggle notifikasi (true/false)
final notifProvider = StateProvider<bool>((ref) => false);

/// Provider untuk menyimpan nama user
final namaProvider = StateProvider<String>((ref) => "");

// 🔥 Provider untuk filter kategori
final kategoriProvider = StateProvider<String>((ref) => "Semua");

// 🔥 Data produk (dummy)
class Produk {
  final String nama;
  final String kategori;
  Produk(this.nama, this.kategori);
}

final produkList = [
  Produk("Apel", "Buah"),
  Produk("Pisang", "Buah"),
  Produk("Wortel", "Sayur"),
  Produk("Bayam", "Sayur"),
  Produk("Kopi", "Minuman"),
  Produk("Susu", "Minuman"),
];
