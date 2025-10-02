import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';
import 'theme_provider.dart';
import 'auth_provider.dart';
import 'dart:math';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final kategori = ref.watch(kategoriProvider);
    final isDark = themeMode == ThemeMode.dark;

    // 🔥 Filter produk
    final filteredProduk = kategori == "Semua"
        ? produkList
        : produkList.where((p) => p.kategori == kategori).toList();

    // 🔥 Random rekomendasi produk
    final rekomendasiProduk = List.of(produkList)..shuffle(Random());
    final rekomendasi = rekomendasiProduk.take(4).toList();

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Selamat Datang!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: isDark ? Colors.amber : Colors.deepPurple,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).state =
                  isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar Modern
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[500]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari produk favoritmu...",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.filter_list, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),

            // 🎯 Promo Banner dengan Gradient
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6D5DF6), Color(0xFFBB6BD9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "PROMO",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Diskon Hingga 50%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Khusus produk terpilih",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.local_offer, color: Colors.white, size: 40),
                    ),
                  ],
                ),
              ),
            ),

            // 🏷️ Section Header dengan Filter Chips
            _buildSectionHeader("Produk Populer", "Lihat Semua"),
            const SizedBox(height: 16),

            // 🔥 Filter Chips Modern
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["Semua", "Buah", "Sayur", "Minuman", "Snack", "Roti"].map((k) {
                  final isSelected = kategori == k;
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        k,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) {
                        ref.read(kategoriProvider.notifier).state = k;
                      },
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      selectedColor: Colors.deepPurpleAccent,
                      checkmarkColor: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // 🛍️ Produk Grid dengan Card Modern
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProduk.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final produk = filteredProduk[index];
                return _buildProductCard(produk, isDark);
              },
            ),

            const SizedBox(height: 30),

            // ⭐ Rekomendasi Section
            _buildSectionHeader("Rekomendasi Untukmu", ""),
            const SizedBox(height: 16),

            // 🎁 Rekomendasi Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rekomendasi.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final produk = rekomendasi[index];
                return _buildProductCard(produk, isDark);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // 🛒 Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Belanja',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profil',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        if (actionText.isNotEmpty)
          Text(
            actionText,
            style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _buildProductCard(Produk produk, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Placeholder
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _getCategoryColor(produk.kategori).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(
                _getCategoryIcon(produk.kategori),
                color: _getCategoryColor(produk.kategori),
                size: 40,
              ),
            ),
          ),
          
          // Product Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk.nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  produk.kategori,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rp${produk.harga}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String kategori) {
    switch (kategori.toLowerCase()) {
      case "buah":
        return Colors.green;
      case "sayur":
        return Colors.lightGreen;
      case "minuman":
        return Colors.blue;
      case "snack":
        return Colors.orange;
      case "roti":
        return Colors.amber;
      default:
        return Colors.deepPurple;
    }
  }

  IconData _getCategoryIcon(String kategori) {
    switch (kategori.toLowerCase()) {
      case "buah":
        return Icons.apple;
      case "sayur":
        return Icons.eco;
      case "minuman":
        return Icons.local_drink;
      case "snack":
        return Icons.cookie;
      case "roti":
        return Icons.bakery_dining;
      default:
        return Icons.shopping_bag;
    }
  }
}

// Contoh model Produk (sesuaikan dengan file providers.dart Anda)
class Produk {
  final String nama;
  final String kategori;
  final int harga;

  Produk({required this.nama, required this.kategori, required this.harga});
}

// Contoh data produk
final List<Produk> produkList = [
  Produk(nama: "Apel Merah", kategori: "Buah", harga: 25000),
  Produk(nama: "Brokoli Segar", kategori: "Sayur", harga: 15000),
  Produk(nama: "Jus Jeruk", kategori: "Minuman", harga: 12000),
  Produk(nama: "Pisang Cavendish", kategori: "Buah", harga: 18000),
  Produk(nama: "Wortel Organik", kategori: "Sayur", harga: 8000),
  Produk(nama: "Air Mineral", kategori: "Minuman", harga: 5000),
  Produk(nama: "Keripik Kentang", kategori: "Snack", harga: 10000),
  Produk(nama: "Roti Tawar", kategori: "Roti", harga: 12000),
];