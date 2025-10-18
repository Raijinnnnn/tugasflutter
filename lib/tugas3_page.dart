import 'package:flutter/material.dart';
import 'dart:math';

// --- MODEL DATA ---
// Model untuk merepresentasikan sebuah produk.
class Produk {
  final String nama;
  final String kategori;
  final int harga;
  final String imageUrl;

  Produk({
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.imageUrl,
  });
}

// --- CONTOH DATA PRODUK ---
// Daftar produk yang akan ditampilkan di aplikasi.
final List<Produk> produkList = [
  Produk(
    nama: "Apel Merah",
    kategori: "Buah",
    harga: 25000,
    imageUrl: "https://images.unsplash.com/photo-1579613832125-5d34a13ffe2a?w=500&q=80",
  ),
  Produk(
    nama: "Brokoli Segar",
    kategori: "Sayur",
    harga: 15000,
    imageUrl: "https://images.unsplash.com/photo-1587351177732-5b0739d16a3f?w=500&q=80",
  ),
  Produk(
    nama: "Jus Jeruk",
    kategori: "Minuman",
    harga: 12000,
    imageUrl: "https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=500&q=80",
  ),
  Produk(
    nama: "Keripik Kentang",
    kategori: "Snack",
    harga: 10000,
    imageUrl: "https://images.unsplash.com/photo-1599490659213-e2b922750b38?w=500&q=80",
  ),
  Produk(
    nama: "Susu Cokelat",
    kategori: "Minuman",
    harga: 18000,
    imageUrl: "https://images.unsplash.com/photo-1563637135-227311776840?w=500&q=80",
  ),
  Produk(
    nama: "Wortel",
    kategori: "Sayur",
    harga: 8000,
    imageUrl: "https://images.unsplash.com/photo-1590868309235-ea34bed7bd7f?w=500&q=80",
  ),
];


class Tugas3Page extends StatefulWidget {
  const Tugas3Page({super.key});

  @override
  State<Tugas3Page> createState() => _Tugas3PageState();
}

class _Tugas3PageState extends State<Tugas3Page> {
  // --- STATE MANAGEMENT ---
  final List<Produk> _keranjang = []; // Menyimpan item di keranjang
  String _kategoriDipilih = 'Semua'; // Kategori yang sedang aktif
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Listener untuk memantau input pada search bar
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  // --- UI BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    // --- LOGIKA FILTER & PENCARIAN ---
    final List<Produk> produkTampil = produkList.where((produk) {
      final cocokKategori = _kategoriDipilih == 'Semua' || produk.kategori == _kategoriDipilih;
      final cocokSearch = produk.nama.toLowerCase().contains(_searchQuery.toLowerCase());
      return cocokKategori && cocokSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Segar'),
        centerTitle: true,
        actions: [
          // Tombol untuk melihat keranjang
          IconButton(
            icon: Badge(
              label: Text(_keranjang.length.toString()),
              isLabelVisible: _keranjang.isNotEmpty,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: _tampilkanKeranjang,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Cari Produk Favoritmu", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  // --- FITUR PENCARIAN ---
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari buah, sayur, atau snack...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Kategori", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  // --- FITUR FILTER KATEGORI ---
                  _buildFilterKategori(),
                ],
              ),
            ),
          ),
          // --- TAMPILAN PRODUK ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: produkTampil.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Text(
                          'Produk tidak ditemukan',
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildProductCard(produkTampil[index]);
                      },
                      childCount: produkTampil.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER ---
  Widget _buildFilterKategori() {
    final kategori = ['Semua', 'Buah', 'Sayur', 'Minuman', 'Snack'];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: kategori.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = kategori[index];
          final isSelected = _kategoriDipilih == item;
          return ChoiceChip(
            label: Text(item),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _kategoriDipilih = item;
                });
              }
            },
            selectedColor: Colors.deepPurple,
            labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Produk produk) {
    return GestureDetector(
      onTap: () => _tambahKeKeranjang(produk),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                produk.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(produk.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Rp${produk.harga}", style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- LOGIKA APLIKASI ---
  void _tambahKeKeranjang(Produk produk) {
    setState(() {
      _keranjang.add(produk);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${produk.nama} ditambahkan ke keranjang!'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _tampilkanKeranjang() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Keranjang Kamu"),
        content: _keranjang.isEmpty
            ? const Text("Keranjang masih kosong.")
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _keranjang.length,
                  itemBuilder: (context, index) {
                    final produk = _keranjang[index];
                    return ListTile(
                      leading: Image.network(produk.imageUrl, width: 40, height: 40, fit: BoxFit.cover),
                      title: Text(produk.nama),
                      subtitle: Text("Rp${produk.harga}"),
                    );
                  },
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }
}

