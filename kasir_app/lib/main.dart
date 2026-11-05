import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const JoneBakeryApp());

const Color navy = Color(0xFF23345D);
const Color cream = Color(0xFFFFF8EF);
const Color orange = Color(0xFFE89A55);
const Color creamAccent = Color(0xFFFFE7CC);

class UserAccount {
  final String name;
  final String email;
  final String password;

  const UserAccount({
    required this.name,
    required this.email,
    required this.password,
  });
}

class Product {
  final String id;
  String name;
  String category;
  int price;
  int stock;
  IconData icon;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    this.icon = Icons.bakery_dining,
    this.imageUrl = '',
  });
}

class BakeryStoreInfo {
  static const String name = 'JONE BAKERY';
  static const String brandType = 'TOKO ROTI & PASTRY ARTISAN';
  static const String tagline = 'Roti & Pastry Artisan Segar Setiap Hari';
  static const String address = 'Jl. Senopati Raya No. 45, Kebayoran Baru, Jakarta Selatan 12190';
  static const String phone = '+62 812-8899-7766';
  static const String hours = 'Buka Setiap Hari: 07.00 - 21.00 WIB';
  static const String instagram = '@jonebakery.id';
  static const String email = 'kontak@jonebakery.com';
  static const String storeImageUrl =
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=700&auto=format&fit=crop&q=80';
  static const String description =
      'Jone Bakery adalah toko roti & pastry artisan modern yang menghidupkan tradisi roti autentik Eropa. Setiap adonan kami dibuat dengan 100% mentega murni Prancis dan ragi alami (sourdough) yang difermentasi 24 jam. Tanpa bahan pengawet kimia, dipanggang hangat langsung dari oven setiap pagi.';
}

const Map<String, String> bakeryPhotoPresets = {
  'Croissant': 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500&auto=format&fit=crop&q=80',
  'Roti Cokelat': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&auto=format&fit=crop&q=80',
  'Donat Salju': 'https://images.unsplash.com/photo-1527515545081-5db817172677?w=500&auto=format&fit=crop&q=80',
  'Cinnamon Roll': 'https://images.unsplash.com/photo-1509365465985-25d11c17e812?w=500&auto=format&fit=crop&q=80',
  'Roti Sobek Keju': 'https://images.unsplash.com/photo-1586444248902-2f64eddc13df?w=500&auto=format&fit=crop&q=80',
  'Muffin Blueberry': 'https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=500&auto=format&fit=crop&q=80',
  'Baguette Prancis': 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=500&auto=format&fit=crop&q=80',
  'Choco Lava Cake': 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500&auto=format&fit=crop&q=80',
  'Kopi Susu': 'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=500&auto=format&fit=crop&q=80',
  'Matcha Latte': 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500&auto=format&fit=crop&q=80',
};

class BakeryLogoPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;

  BakeryLogoPainter({
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer double ring
    final ringPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04;
    canvas.drawCircle(center, radius * 0.92, ringPaint);

    final thinRingPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.015;
    canvas.drawCircle(center, radius * 0.82, thinRingPaint);

    // Artisan wheat ears left & right
    final wheatPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 4; i++) {
      final yOffset = center.dy - radius * 0.35 + (i * radius * 0.18);
      // Left wheat grain
      final leftRect = Rect.fromCenter(
        center: Offset(center.dx - radius * 0.52 + (i * 2.5), yOffset),
        width: radius * 0.18,
        height: radius * 0.10,
      );
      canvas.save();
      canvas.translate(leftRect.center.dx, leftRect.center.dy);
      canvas.rotate(-0.55);
      canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: leftRect.width, height: leftRect.height), wheatPaint);
      canvas.restore();

      // Right wheat grain
      final rightRect = Rect.fromCenter(
        center: Offset(center.dx + radius * 0.52 - (i * 2.5), yOffset),
        width: radius * 0.18,
        height: radius * 0.10,
      );
      canvas.save();
      canvas.translate(rightRect.center.dx, rightRect.center.dy);
      canvas.rotate(0.55);
      canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: rightRect.width, height: rightRect.height), wheatPaint);
      canvas.restore();
    }

    // Classic Baker's Toque / Bread Arch in center
    final domePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05
      ..strokeCap = StrokeCap.round;

    final archPath = Path();
    archPath.moveTo(center.dx - radius * 0.35, center.dy + radius * 0.15);
    archPath.quadraticBezierTo(
      center.dx,
      center.dy - radius * 0.55,
      center.dx + radius * 0.35,
      center.dy + radius * 0.15,
    );
    canvas.drawPath(archPath, domePaint);

    // Horizontal Baker's Ribbon baseline
    final ribbonPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;
    final ribbonRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.22),
        width: radius * 0.75,
        height: radius * 0.16,
      ),
      Radius.circular(radius * 0.08),
    );
    canvas.drawRRect(ribbonRect, ribbonPaint);

    // Monogram 'JB' inside the badge
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'JB',
        style: TextStyle(
          color: primaryColor,
          fontSize: size.width * 0.22,
          fontWeight: FontWeight.w900,
          letterSpacing: -1,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - radius * 0.18),
    );
  }

  @override
  bool shouldRepaint(covariant BakeryLogoPainter oldDelegate) =>
      oldDelegate.primaryColor != primaryColor || oldDelegate.accentColor != accentColor;
}

class JoneBakeryLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color textColor;
  final Color? subtitleColor;
  final bool vertical;

  const JoneBakeryLogo({
    super.key,
    this.size = 40,
    this.showText = true,
    this.textColor = navy,
    this.subtitleColor,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    final emblem = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cream,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(size * 0.08),
        child: CustomPaint(
          size: Size(size, size),
          painter: BakeryLogoPainter(
            primaryColor: navy,
            accentColor: orange,
          ),
        ),
      ),
    );

    if (!showText) return emblem;

    final textColumn = Column(
      crossAxisAlignment: vertical ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'JONE BAKERY',
          style: TextStyle(
            color: textColor,
            fontSize: size * 0.38 > 24 ? 24 : (size * 0.38 < 13 ? 13 : size * 0.38),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          'ROTI & PASTRY ARTISAN • SEJAK 2024',
          style: TextStyle(
            color: subtitleColor ?? (textColor == Colors.white ? Colors.white70 : orange),
            fontSize: size * 0.16 > 11 ? 11 : (size * 0.16 < 8 ? 8 : size * 0.16),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );

    if (vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          emblem,
          SizedBox(height: size * 0.2),
          textColumn,
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        emblem,
        SizedBox(width: size * 0.28),
        textColumn,
      ],
    );
  }
}

class ProductThumbnail extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  const ProductThumbnail({
    super.key,
    required this.imageUrl,
    this.width = 54,
    this.height = 54,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().isEmpty) {
      return _buildPlaceholder();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (ctx, child, progress) {
          if (progress == null) return child;
          return Container(
            width: width,
            height: height,
            color: creamAccent.withValues(alpha: 0.5),
            child: const Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2, color: orange),
              ),
            ),
          );
        },
        errorBuilder: (ctx, err, stack) => _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: creamAccent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: orange.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Icon(Icons.bakery_dining, color: navy, size: width * 0.5),
      ),
    );
  }
}


class LineItem {
  final Product product;
  int qty;

  LineItem({required this.product, required this.qty});

  int get subtotal => product.price * qty;
}

class Receipt {
  final String id;
  final List<LineItem> items;
  final int total;
  final int paidAmount;
  final int change;
  final String paymentMethod;
  final String customerName;
  final DateTime date;

  Receipt({
    required this.id,
    required this.items,
    required this.total,
    required this.paidAmount,
    required this.change,
    required this.paymentMethod,
    required this.customerName,
    required this.date,
  });
}

class StockMutation {
  final String id;
  final String productName;
  final int delta;
  final int finalStock;
  final String reason;
  final DateTime date;

  StockMutation({
    required this.id,
    required this.productName,
    required this.delta,
    required this.finalStock,
    required this.reason,
    required this.date,
  });
}

// Global Demo Data
final List<UserAccount> registeredUsers = [
  const UserAccount(
    name: 'Admin Kasir',
    email: 'admin@jonebakery.com',
    password: 'admin123',
  ),
  const UserAccount(
    name: 'Kasir Shift 1',
    email: 'kasir@jonebakery.com',
    password: 'kasir123',
  ),
];

UserAccount? currentUser = registeredUsers[0];

final List<Product> inventory = [
  Product(
    id: 'P01',
    name: 'Croissant Mentega Prancis',
    category: 'Pastry',
    price: 18000,
    stock: 24,
    icon: Icons.bakery_dining,
    imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P02',
    name: 'Roti Cokelat Spesial',
    category: 'Roti',
    price: 12000,
    stock: 30,
    icon: Icons.breakfast_dining,
    imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P03',
    name: 'Donat Salju Gula',
    category: 'Donat',
    price: 8000,
    stock: 35,
    icon: Icons.donut_large,
    imageUrl: 'https://images.unsplash.com/photo-1527515545081-5db817172677?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P04',
    name: 'Roti Kayu Manis (Cinnamon Roll)',
    category: 'Pastry',
    price: 16000,
    stock: 18,
    icon: Icons.cookie,
    imageUrl: 'https://images.unsplash.com/photo-1509365465985-25d11c17e812?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P05',
    name: 'Roti Sobek Keju',
    category: 'Roti',
    price: 14000,
    stock: 20,
    icon: Icons.bakery_dining,
    imageUrl: 'https://images.unsplash.com/photo-1586444248902-2f64eddc13df?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P06',
    name: 'Muffin Blueberry',
    category: 'Kue',
    price: 15000,
    stock: 15,
    icon: Icons.cake_outlined,
    imageUrl: 'https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P07',
    name: 'Baguette Prancis',
    category: 'Roti',
    price: 22000,
    stock: 8,
    icon: Icons.bakery_dining,
    imageUrl: 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P08',
    name: 'Kue Cokelat Lumer (Choco Lava)',
    category: 'Kue',
    price: 25000,
    stock: 4,
    icon: Icons.cake,
    imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P09',
    name: 'Kopi Susu Gula Aren',
    category: 'Minuman',
    price: 18000,
    stock: 40,
    icon: Icons.local_cafe,
    imageUrl: 'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=500&auto=format&fit=crop&q=80',
  ),
  Product(
    id: 'P10',
    name: 'Es Matcha Latte Segar',
    category: 'Minuman',
    price: 20000,
    stock: 3,
    icon: Icons.emoji_food_beverage,
    imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500&auto=format&fit=crop&q=80',
  ),
];

final List<Receipt> receipts = [
  Receipt(
    id: 'JB-261028-001',
    items: [
      LineItem(product: inventory[0], qty: 2),
      LineItem(product: inventory[8], qty: 1),
    ],
    total: 54000,
    paidAmount: 100000,
    change: 46000,
    paymentMethod: 'Tunai',
    customerName: 'Kak Sarah',
    date: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  Receipt(
    id: 'JB-261028-002',
    items: [
      LineItem(product: inventory[2], qty: 4),
      LineItem(product: inventory[1], qty: 2),
    ],
    total: 56000,
    paidAmount: 56000,
    change: 0,
    paymentMethod: 'QRIS',
    customerName: 'Meja 2',
    date: DateTime.now().subtract(const Duration(minutes: 50)),
  ),
];

final List<StockMutation> stockMutations = [
  StockMutation(
    id: 'M01',
    productName: 'Croissant Mentega Prancis',
    delta: 24,
    finalStock: 24,
    reason: 'Produksi Pagi Toko',
    date: DateTime.now().subtract(const Duration(hours: 6)),
  ),
  StockMutation(
    id: 'M02',
    productName: 'Es Matcha Latte Segar',
    delta: -5,
    finalStock: 3,
    reason: 'Penjualan Kasir',
    date: DateTime.now().subtract(const Duration(hours: 1)),
  ),
];

String money(int n) {
  final s = n.toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    b.write(s[i]);
    if ((s.length - i - 1) > 0 && (s.length - i - 1) % 3 == 0) b.write('.');
  }
  return 'Rp$b';
}

String formatDateTime(DateTime dt) {
  final d = dt.day.toString().padLeft(2, '0');
  final m = dt.month.toString().padLeft(2, '0');
  final y = dt.year.toString();
  final hh = dt.hour.toString().padLeft(2, '0');
  final mm = dt.minute.toString().padLeft(2, '0');
  return '$d/$m/$y $hh:$mm';
}

class JoneBakeryApp extends StatelessWidget {
  const JoneBakeryApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'JONE BAKERY POS',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: navy,
        primary: navy,
        secondary: orange,
        surface: cream,
      ),
      scaffoldBackgroundColor: cream,
      appBarTheme: const AppBarTheme(
        backgroundColor: cream,
        elevation: 0,
        iconTheme: IconThemeData(color: navy),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w900,
          color: navy,
          fontSize: 20,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.06), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: navy, width: 2),
        ),
      ),
    ),
    home: const SplashPage(),
  );
}

// ---------------------------------------------------------------------------
// 1. SPLASH SCREEN
// ---------------------------------------------------------------------------
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: navy,
    body: SafeArea(
      child: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: animation,
              builder: (_, child) => Transform.translate(
                offset: Offset(0, -6 * animation.value),
                child: child,
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  JoneBakeryLogo(
                    size: 110,
                    showText: true,
                    vertical: true,
                    textColor: Colors.white,
                    subtitleColor: creamAccent,
                  ),
                  SizedBox(height: 12),
                  Text(
                    BakeryStoreInfo.tagline,
                    style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 0.5),
                  ),
                  SizedBox(height: 28),
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(strokeWidth: 2.5, color: orange),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Text(
              '${BakeryStoreInfo.address}\nTelp: ${BakeryStoreInfo.phone}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white38, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 2. LOGIN SCREEN
// ---------------------------------------------------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController(text: 'admin@jonebakery.com');
  final password = TextEditingController(text: 'admin123');
  bool hide = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void enter() {
    final em = email.text.trim();
    final pw = password.text;
    if (em.isEmpty || pw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi email dan password terlebih dahulu.')),
      );
      return;
    }

    final found = registeredUsers.where((u) => u.email.toLowerCase() == em.toLowerCase() && u.password == pw);
    if (found.isNotEmpty) {
      currentUser = found.first;
    } else {
      currentUser = UserAccount(name: em.split('@').first, email: em, password: pw);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selamat datang kembali, ${currentUser?.name}!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: JoneBakeryLogo(
                    size: 80,
                    vertical: true,
                    showText: true,
                    textColor: navy,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Masuk Kasir POS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Akses inventaris & transaksi toko ${BakeryStoreInfo.name}.\n${BakeryStoreInfo.address}',
                  style: TextStyle(color: Colors.black54, fontSize: 12, height: 1.3),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Email Kasir',
                  style: TextStyle(fontWeight: FontWeight.w600, color: navy),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: 'admin@jonebakery.com',
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Kata Sandi (Password)',
                  style: TextStyle(fontWeight: FontWeight.w600, color: navy),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: password,
                  obscureText: hide,
                  onSubmitted: (_) => enter(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: 'Masukkan kata sandi',
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => hide = !hide),
                      icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: navy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: enter,
                    child: const Text(
                      'MASUK KE SISTEM',
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun? '),
                    TextButton(
                      onPressed: () async {
                        final registeredEmail = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterPage()),
                        );
                        if (registeredEmail != null) {
                          setState(() {
                            email.text = registeredEmail;
                            password.text = '';
                          });
                        }
                      },
                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(fontWeight: FontWeight.bold, color: orange),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: orange),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.flash_on, color: orange, size: 18),
                    label: const Text(
                      'Isi Otomatis Akun Demo',
                      style: TextStyle(color: navy, fontSize: 13),
                    ),
                    onPressed: () {
                      setState(() {
                        email.text = 'admin@jonebakery.com';
                        password.text = 'admin123';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 3. REGISTER SCREEN (REGIS)
// ---------------------------------------------------------------------------
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool hidePassword = true;
  bool hideConfirm = true;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void register() {
    final n = name.text.trim();
    final em = email.text.trim();
    final pw = password.text;
    final cpw = confirmPassword.text;

    if (n.isEmpty || em.isEmpty || pw.isEmpty || cpw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua kolom wajib diisi.')),
      );
      return;
    }

    if (!em.contains('@') || !em.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format email tidak valid.')),
      );
      return;
    }

    if (pw.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password minimal 6 karakter.')),
      );
      return;
    }

    if (pw != cpw) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi password tidak cocok.')),
      );
      return;
    }

    if (registeredUsers.any((u) => u.email.toLowerCase() == em.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ini sudah terdaftar! Gunakan email lain.')),
      );
      return;
    }

    final newUser = UserAccount(name: n, email: em, password: pw);
    registeredUsers.add(newUser);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pendaftaran berhasil! Silakan masuk sebagai $n.')),
    );

    Navigator.pop(context, em);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Daftar Kasir Baru'),
      backgroundColor: cream,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: navy),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: JoneBakeryLogo(
                    size: 70,
                    vertical: true,
                    showText: true,
                    textColor: navy,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Buat Akun Kasir',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Daftarkan kasir baru untuk mengelola transaksi Jone Bakery.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 22),
                const Text('Nama Lengkap', style: TextStyle(fontWeight: FontWeight.w600, color: navy)),
                const SizedBox(height: 6),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: 'Contoh: Ahmad Kasir',
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Email', style: TextStyle(fontWeight: FontWeight.w600, color: navy)),
                const SizedBox(height: 6),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: 'kasir@jonebakery.com',
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Kata Sandi', style: TextStyle(fontWeight: FontWeight.w600, color: navy)),
                const SizedBox(height: 6),
                TextField(
                  controller: password,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    hintText: 'Minimal 6 karakter',
                    suffixIcon: IconButton(
                      icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => hidePassword = !hidePassword),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Konfirmasi Kata Sandi', style: TextStyle(fontWeight: FontWeight.w600, color: navy)),
                const SizedBox(height: 6),
                TextField(
                  controller: confirmPassword,
                  obscureText: hideConfirm,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_reset),
                    hintText: 'Ulangi kata sandi',
                    suffixIcon: IconButton(
                      icon: Icon(hideConfirm ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => hideConfirm = !hideConfirm),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: navy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: register,
                    child: const Text(
                      'DAFTAR SEKARANG',
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah punya akun? '),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Masuk di sini',
                        style: TextStyle(fontWeight: FontWeight.bold, color: orange),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 4. MAIN PAGE CONTAINER WITH TABS
// ---------------------------------------------------------------------------
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  void refresh() => setState(() {});

  void switchTab(int i) {
    setState(() => index = i);
  }

  void logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Keluar', style: TextStyle(color: navy, fontWeight: FontWeight.bold)),
        content: const Text('Apakah Anda yakin ingin keluar dari sesi kasir saat ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (_) => false,
              );
            },
            child: const Text('Ya, Keluar'),
          ),
        ],
      ),
    );
  }

  void showStoreInfo() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            JoneBakeryLogo(size: 38, showText: false),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  BakeryStoreInfo.name,
                  style: TextStyle(color: navy, fontWeight: FontWeight.w900, fontSize: 18),
                ),
                Text(
                  BakeryStoreInfo.brandType,
                  style: TextStyle(color: orange, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: orange.withValues(alpha: 0.25)),
                ),
                child: const Text(
                  BakeryStoreInfo.description,
                  style: TextStyle(fontSize: 12.5, height: 1.45, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Informasi & Lokasi Toko', style: TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 14)),
              const SizedBox(height: 8),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.location_on, color: orange),
                title: const Text('Alamat Gerai', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                subtitle: const Text(BakeryStoreInfo.address, style: TextStyle(fontSize: 12)),
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.access_time_filled, color: orange),
                title: const Text('Jam Operasional', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                subtitle: const Text(BakeryStoreInfo.hours, style: TextStyle(fontSize: 12)),
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.phone, color: orange),
                title: const Text('Kontak Pemesanan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                subtitle: const Text('${BakeryStoreInfo.phone} • ${BakeryStoreInfo.instagram}', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: navy),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void showAbout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            JoneBakeryLogo(size: 34, showText: false),
            SizedBox(width: 10),
            Text('JONE BAKERY POS', style: TextStyle(color: navy, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Aplikasi Kasir & Inventaris Toko Roti Modern.'),
            const SizedBox(height: 8),
            Text('Versi: 1.0.0 Web Ready', style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
            const SizedBox(height: 4),
            Text('Kasir Aktif: ${currentUser?.name ?? "Admin"} (${currentUser?.email ?? "-"})', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            const Text('Fitur Lengkap:'),
            const Text('• Logo Vektor Resmi & Foto Produk Asli'),
            const Text('• Login & Registrasi Kasir'),
            const Text('• Katalog & Manajemen Produk (CRUD)'),
            const Text('• POS Kasir, Keranjang Belanja & Cetak Struk'),
            const Text('• Manajemen Stok, Alert & Riwayat Mutasi'),
            const Text('• Laporan Keuangan & Filter Tanggal'),
          ],
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: navy),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeTab(onNavigate: switchTab),
      ProductTab(onChange: refresh),
      CheckoutTab(
        onSale: (sale) {
          setState(() {
            receipts.insert(0, sale);
          });
        },
      ),
      StockTab(onChange: refresh),
      const ReportTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            JoneBakeryLogo(size: 34, showText: false),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'JONE BAKERY',
                  style: TextStyle(fontWeight: FontWeight.w900, color: navy, letterSpacing: 1.2, fontSize: 16),
                ),
                Text(
                  BakeryStoreInfo.tagline,
                  style: TextStyle(fontSize: 9, color: orange, fontWeight: FontWeight.bold, letterSpacing: 0.3),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: cream,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: creamAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person, size: 16, color: navy),
                const SizedBox(width: 4),
                Text(
                  currentUser?.name ?? 'Admin',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: navy),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Profil & Info Toko',
            icon: const Icon(Icons.storefront_rounded, color: navy),
            onPressed: showStoreInfo,
          ),
          IconButton(
            tooltip: 'Tentang Aplikasi',
            icon: const Icon(Icons.info_outline, color: navy),
            onPressed: showAbout,
          ),
          IconButton(
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout, color: navy),
            onPressed: logout,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1B2B4C),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: orange.withValues(alpha: 0.35), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Theme(
            data: Theme.of(context).copyWith(
              navigationBarTheme: NavigationBarThemeData(
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12);
                  }
                  return const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 11.5);
                }),
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const IconThemeData(color: Colors.white);
                  }
                  return const IconThemeData(color: Colors.white70);
                }),
              ),
            ),
            child: NavigationBar(
              height: 66,
              elevation: 0,
              selectedIndex: index,
              onDestinationSelected: switchTab,
              backgroundColor: Colors.transparent,
              indicatorColor: orange,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard_rounded),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(Icons.inventory_2_outlined),
                  selectedIcon: Icon(Icons.inventory_2_rounded),
                  label: 'Produk',
                ),
                NavigationDestination(
                  icon: Icon(Icons.point_of_sale_outlined),
                  selectedIcon: Icon(Icons.point_of_sale_rounded),
                  label: 'Kasir POS',
                ),
                NavigationDestination(
                  icon: Icon(Icons.warehouse_outlined),
                  selectedIcon: Icon(Icons.warehouse_rounded),
                  label: 'Stok',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart_rounded),
                  label: 'Laporan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. TAB 1: BERANDA (HOME)
// ---------------------------------------------------------------------------
class HomeTab extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const HomeTab({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final revenue = receipts.fold<int>(0, (sum, r) => sum + r.total);
    final lowStockCount = inventory.where((p) => p.stock <= 5).length;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        // Welcome Hero Banner dengan Foto Gerai Toko
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1B2B4C), Color(0xFF283F72)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: navy.withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 640;

              final textContent = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          JoneBakeryLogo(size: 28, showText: false),
                          SizedBox(width: 8),
                          Text(
                            'SISTEM KASIR AKTIF',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          currentUser?.name ?? 'Admin Kasir',
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Roti Hangat Setiap Hari,\nSemangat Bahagia!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kelola transaksi kasir POS, katalog produk, dan stok persediaan roti artisan dengan mudah dan cepat.',
                    style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle_outline, color: orange, size: 14),
                            SizedBox(width: 5),
                            Text('Dipanggang Tiap Pagi', style: TextStyle(color: Colors.white, fontSize: 11)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_outline, color: orange, size: 14),
                            SizedBox(width: 5),
                            Text('100% Mentega Prancis', style: TextStyle(color: Colors.white, fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );

              final storePhotoCard = Container(
                width: isWide ? 220 : double.infinity,
                height: isWide ? 150 : 160,
                margin: EdgeInsets.only(top: isWide ? 0 : 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: orange.withValues(alpha: 0.5), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        BakeryStoreInfo.storeImageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (ctx, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            color: navy.withValues(alpha: 0.5),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: orange),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (ctx, err, stack) => Container(
                          color: creamAccent,
                          child: const Center(
                            child: Icon(Icons.storefront_rounded, size: 48, color: navy),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.storefront, color: orange, size: 14),
                              SizedBox(width: 4),
                              Text(
                                'Gerai Utama Jone Bakery',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: textContent),
                    const SizedBox(width: 20),
                    storePhotoCard,
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textContent,
                  storePhotoCard,
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: StatTile(
                title: 'Total Produk',
                value: '${inventory.length}',
                icon: Icons.inventory_2,
                color: orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile(
                title: 'Transaksi',
                value: '${receipts.length}',
                icon: Icons.receipt_long,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatTile(
                title: 'Pendapatan',
                value: money(revenue),
                icon: Icons.payments,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile(
                title: 'Stok Kritis',
                value: '$lowStockCount item',
                icon: Icons.warning_amber_rounded,
                color: lowStockCount > 0 ? Colors.red.shade600 : Colors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        // Action shortcuts
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => onNavigate(2), // Transaksi
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Buka Kasir POS', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: navy, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => onNavigate(3), // Stok
                icon: const Icon(Icons.warehouse, color: navy),
                label: const Text('Kelola Stok', style: TextStyle(fontWeight: FontWeight.bold, color: navy)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),

        // Tentang Toko & Lokasi Gerai Section
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  JoneBakeryLogo(size: 32, showText: false),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TENTANG JONE BAKERY',
                        style: TextStyle(fontWeight: FontWeight.w900, color: navy, fontSize: 15, letterSpacing: 0.8),
                      ),
                      Text(
                        BakeryStoreInfo.brandType,
                        style: TextStyle(color: orange, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                BakeryStoreInfo.description,
                style: const TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.45),
              ),
              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: orange, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      BakeryStoreInfo.address,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: navy),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time_filled, color: orange, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    BakeryStoreInfo.hours,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, color: orange, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '${BakeryStoreInfo.phone}  •  ${BakeryStoreInfo.instagram}',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  '100% Mentega Prancis',
                  'Ragi Alami Sourdough',
                  'Dipanggang Segar Tiap Pagi',
                  'Makan di Tempat & Bawa Pulang',
                  'Tersertifikasi Halal',
                ].map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: creamAccent.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: orange.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: navy),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Produk Pilihan',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: navy),
            ),
            TextButton(
              onPressed: () => onNavigate(1), // Produk
              child: const Text('Lihat Semua →', style: TextStyle(color: orange, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ...inventory.take(4).map(
          (p) => Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: ProductThumbnail(
                imageUrl: p.imageUrl,
                width: 48,
                height: 48,
                borderRadius: 10,
              ),
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Row(
                children: [
                  Text('${p.category} • '),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: p.stock <= 5 ? Colors.red.shade50 : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Stok: ${p.stock}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: p.stock <= 5 ? Colors.red.shade700 : Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Text(
                money(p.price),
                style: const TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Transaksi Terakhir',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: navy),
        ),
        const SizedBox(height: 6),
        if (receipts.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Belum ada transaksi hari ini.'),
            ),
          )
        else
          ...receipts.take(2).map(
            (r) => Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(Icons.receipt, color: Colors.blue.shade800),
                ),
                title: Text(r.customerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${r.id} • ${r.items.length} item • ${r.paymentMethod}'),
                trailing: Text(
                  money(r.total),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 15),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class StatTile extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;

  const StatTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: navy),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 6. TAB 2: PRODUK (KATALOG & CRUD)
// ---------------------------------------------------------------------------
class ProductTab extends StatefulWidget {
  final VoidCallback onChange;

  const ProductTab({super.key, required this.onChange});

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {
  String query = '';
  String selectedCategory = 'Semua';

  final List<String> categories = ['Semua', 'Roti', 'Pastry', 'Donat', 'Kue', 'Minuman'];

  Future<void> addOrEditProduct([Product? editing]) async {
    final name = TextEditingController(text: editing?.name ?? '');
    String category = editing?.category ?? 'Roti';
    final price = TextEditingController(text: editing != null ? editing.price.toString() : '');
    final stock = TextEditingController(text: editing != null ? editing.stock.toString() : '');
    final imageUrlCtrl = TextEditingController(text: editing?.imageUrl ?? (bakeryPhotoPresets[category] ?? ''));
    IconData selectedIcon = editing?.icon ?? Icons.bakery_dining;

    final result = await showDialog<Product>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            editing == null ? 'Tambah Produk Baru' : 'Edit Produk',
            style: const TextStyle(color: navy, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Nama Produk', hintText: 'Misal: Roti Sisir Manis'),
                ),
                const SizedBox(height: 12),
                const Text('Kategori', style: TextStyle(fontWeight: FontWeight.w600, color: navy)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButton<String>(
                    value: category,
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    items: ['Roti', 'Pastry', 'Donat', 'Kue', 'Minuman', 'Lainnya'].map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setDlgState(() {
                          category = val;
                          if (imageUrlCtrl.text.trim().isEmpty && bakeryPhotoPresets.containsKey(val)) {
                            imageUrlCtrl.text = bakeryPhotoPresets[val]!;
                          }
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Harga Satuan (Rp)', hintText: 'Contoh: 15000'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: stock,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Jumlah Stok', hintText: 'Contoh: 20'),
                ),
                const SizedBox(height: 14),
                const Text('Foto Produk (URL Asli):', style: TextStyle(fontWeight: FontWeight.w600, color: navy)),
                const SizedBox(height: 6),
                TextField(
                  controller: imageUrlCtrl,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.image_outlined),
                    hintText: 'https://images.unsplash.com/...',
                    labelText: 'URL Foto Produk',
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Pilih Foto Rekomendasi:', style: TextStyle(fontSize: 11, color: Colors.black54)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: bakeryPhotoPresets.entries.map((entry) {
                    final isSel = imageUrlCtrl.text == entry.value;
                    return ActionChip(
                      label: Text(entry.key, style: TextStyle(fontSize: 11, color: isSel ? Colors.white : navy)),
                      backgroundColor: isSel ? navy : creamAccent,
                      onPressed: () {
                        setDlgState(() {
                          imageUrlCtrl.text = entry.value;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: navy),
              onPressed: () {
                final p = int.tryParse(price.text.replaceAll('.', ''));
                final s = int.tryParse(stock.text);
                if (name.text.trim().isEmpty || p == null || s == null || p < 0 || s < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pastikan nama, harga, dan stok diisi dengan benar.')),
                  );
                  return;
                }

                final chosenImg = imageUrlCtrl.text.trim().isEmpty
                    ? (bakeryPhotoPresets[category] ?? 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&auto=format&fit=crop&q=80')
                    : imageUrlCtrl.text.trim();

                if (editing != null) {
                  editing.name = name.text.trim();
                  editing.category = category;
                  editing.price = p;
                  editing.stock = s;
                  editing.icon = selectedIcon;
                  editing.imageUrl = chosenImg;
                  Navigator.pop(ctx, editing);
                } else {
                  final newProd = Product(
                    id: 'P${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                    name: name.text.trim(),
                    category: category,
                    price: p,
                    stock: s,
                    icon: selectedIcon,
                    imageUrl: chosenImg,
                  );
                  Navigator.pop(ctx, newProd);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );

    name.dispose();
    price.dispose();
    stock.dispose();
    imageUrlCtrl.dispose();

    if (result != null) {
      if (editing == null) {
        setState(() => inventory.add(result));
        stockMutations.insert(
          0,
          StockMutation(
            id: 'M${DateTime.now().millisecondsSinceEpoch}',
            productName: result.name,
            delta: result.stock,
            finalStock: result.stock,
            reason: 'Produk Baru Ditambahkan',
            date: DateTime.now(),
          ),
        );
      }
      widget.onChange();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk "${result.name}" berhasil disimpan!')),
      );
    }
  }

  void deleteProduct(Product p) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Produk', style: TextStyle(color: navy, fontWeight: FontWeight.bold)),
        content: Text('Apakah Anda yakin ingin menghapus "${p.name}" dari katalog?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              setState(() => inventory.remove(p));
              widget.onChange();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Produk "${p.name}" telah dihapus.')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = inventory.where((p) {
      final matchQuery = p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.category.toLowerCase().contains(query.toLowerCase());
      final matchCat = selectedCategory == 'Semua' || p.category == selectedCategory;
      return matchQuery && matchCat;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Katalog Produk', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: navy)),
                  Text('Kelola daftar menu dan harga produk toko.', style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: navy),
              onPressed: () => addOrEditProduct(),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Tambah'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextField(
          onChanged: (v) => setState(() => query = v),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Cari produk atau kategori...',
            suffixIcon: query.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => query = ''))
                : null,
          ),
        ),
        const SizedBox(height: 12),
        // Filter category chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((c) {
              final isSel = selectedCategory == c;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(c),
                  selected: isSel,
                  selectedColor: navy,
                  backgroundColor: Colors.white,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSel ? Colors.white : navy,
                    fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (_) => setState(() => selectedCategory = c),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 14),
        if (filtered.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.black26),
                    SizedBox(height: 8),
                    Text('Tidak ada produk yang cocok.', style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ),
          )
        else
          ...filtered.map(
            (p) => Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: ProductThumbnail(
                  imageUrl: p.imageUrl,
                  width: 56,
                  height: 56,
                  borderRadius: 12,
                ),
                title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Row(
                  children: [
                    Text('${p.category}  •  '),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: p.stock == 0
                            ? Colors.red.shade100
                            : (p.stock <= 5 ? Colors.orange.shade100 : Colors.green.shade50),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        p.stock == 0 ? 'Habis (0)' : 'Stok ${p.stock}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: p.stock == 0
                              ? Colors.red.shade800
                              : (p.stock <= 5 ? Colors.orange.shade900 : Colors.green.shade800),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      money(p.price),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 15),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.black54),
                      onSelected: (val) {
                        if (val == 'edit') addOrEditProduct(p);
                        if (val == 'delete') deleteProduct(p);
                      },
                      itemBuilder: (ctx) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [Icon(Icons.edit, size: 18, color: navy), SizedBox(width: 8), Text('Edit')],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [Icon(Icons.delete, size: 18, color: Colors.red), SizedBox(width: 8), Text('Hapus', style: TextStyle(color: Colors.red))],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 7. TAB 3: TRANSAKSI (POS & CHECKOUT)
// ---------------------------------------------------------------------------
class CheckoutTab extends StatefulWidget {
  final ValueChanged<Receipt> onSale;

  const CheckoutTab({super.key, required this.onSale});

  @override
  State<CheckoutTab> createState() => _CheckoutTabState();
}

class _CheckoutTabState extends State<CheckoutTab> {
  final Map<Product, int> cart = {};
  String query = '';
  String selectedCategory = 'Semua';
  String paymentMethod = 'Tunai';
  final customerCtrl = TextEditingController(text: 'Pelanggan Umum');
  final cashPaidCtrl = TextEditingController();

  int get total => cart.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  @override
  void dispose() {
    customerCtrl.dispose();
    cashPaidCtrl.dispose();
    super.dispose();
  }

  void add(Product p) {
    if (p.stock <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Stok "${p.name}" sudah habis!')),
      );
      return;
    }
    final currentQty = cart[p] ?? 0;
    if (currentQty >= p.stock) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Stok "${p.name}" tidak mencukupi (Tersisa: ${p.stock}).')),
      );
      return;
    }
    setState(() => cart[p] = currentQty + 1);
  }

  void change(Product p, int delta) {
    final n = (cart[p] ?? 0) + delta;
    setState(() {
      if (n <= 0) {
        cart.remove(p);
      } else if (n <= p.stock) {
        cart[p] = n;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Stok tersisa hanya ${p.stock}.')),
        );
      }
    });
  }

  void checkout() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang masih kosong. Pilih produk terlebih dahulu.')),
      );
      return;
    }

    int paid = total;
    int changeMoney = 0;

    if (paymentMethod == 'Tunai') {
      final inputVal = int.tryParse(cashPaidCtrl.text.replaceAll('.', '').replaceAll('Rp', ''));
      if (inputVal == null || inputVal < total) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Uang tunai belum cukup! Total belanja: ${money(total)}')),
        );
        return;
      }
      paid = inputVal;
      changeMoney = paid - total;
    }

    final items = cart.entries.map((e) => LineItem(product: e.key, qty: e.value)).toList();

    // Deduct stock and record mutations
    for (final e in cart.entries) {
      e.key.stock -= e.value;
      stockMutations.insert(
        0,
        StockMutation(
          id: 'M${DateTime.now().millisecondsSinceEpoch}',
          productName: e.key.name,
          delta: -e.value,
          finalStock: e.key.stock,
          reason: 'Penjualan Kasir (${customerCtrl.text.trim().isEmpty ? "Pelanggan Umum" : customerCtrl.text.trim()})',
          date: DateTime.now(),
        ),
      );
    }

    final newReceipt = Receipt(
      id: 'JB-${DateTime.now().year.toString().substring(2)}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().day.toString().padLeft(2, '0')}-${(receipts.length + 1).toString().padLeft(3, '0')}',
      items: items,
      total: total,
      paidAmount: paid,
      change: changeMoney,
      paymentMethod: paymentMethod,
      customerName: customerCtrl.text.trim().isEmpty ? 'Pelanggan Umum' : customerCtrl.text.trim(),
      date: DateTime.now(),
    );

    widget.onSale(newReceipt);

    setState(() {
      cart.clear();
      cashPaidCtrl.clear();
    });

    // Show beautiful receipt modal
    showReceiptDialog(newReceipt);
  }

  void showReceiptDialog(Receipt r) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(20),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 54, color: Colors.green),
                const SizedBox(height: 8),
                const Text(
                  'TRANSAKSI BERHASIL',
                  style: TextStyle(fontWeight: FontWeight.w900, color: navy, fontSize: 17),
                ),
                const JoneBakeryLogo(size: 44, showText: false),
                const SizedBox(height: 6),
                const Text(
                  BakeryStoreInfo.name,
                  style: TextStyle(fontWeight: FontWeight.w900, color: navy, fontSize: 16, letterSpacing: 1),
                ),
                const Text(
                  '${BakeryStoreInfo.brandType}\n${BakeryStoreInfo.address}\nTelp: ${BakeryStoreInfo.phone}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.5, color: Colors.black54, height: 1.3),
                ),
                const Divider(height: 24, thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('No. Struk:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text(r.id, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Waktu:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text(formatDateTime(r.date), style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Kasir:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text(currentUser?.name ?? 'Admin', style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Pelanggan:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    Text(r.customerName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(height: 20, thickness: 1),
                ...r.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${item.product.name} (${item.qty}x)',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(money(item.subtotal), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 20, thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('TOTAL BELANJA', style: TextStyle(fontWeight: FontWeight.bold, color: navy)),
                    Text(money(r.total), style: const TextStyle(fontWeight: FontWeight.w900, color: navy, fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Metode (${r.paymentMethod})', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    Text(money(r.paidAmount), style: const TextStyle(fontSize: 12)),
                  ],
                ),
                if (r.paymentMethod == 'Tunai')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Kembalian', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                      Text(money(r.change), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                const Divider(height: 24, thickness: 1),
                const Text(
                  'Terima kasih telah berbelanja di Jone Bakery!\nSelamat menikmati sajian artisan istimewa kami.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
        actions: [
          OutlinedButton.icon(
            icon: const Icon(Icons.copy, size: 16),
            label: const Text('Salin Struk'),
            onPressed: () {
              final text = '''
=== JONE BAKERY ===
${BakeryStoreInfo.brandType}
${BakeryStoreInfo.address}
Telp: ${BakeryStoreInfo.phone}
----------------------------------------
No Struk : ${r.id}
Waktu    : ${formatDateTime(r.date)}
Kasir    : ${currentUser?.name ?? 'Admin'}
Pelanggan: ${r.customerName}
----------------------------------------
${r.items.map((i) => '${i.product.name.padRight(20)} x${i.qty} = ${money(i.subtotal)}').join('\n')}
----------------------------------------
TOTAL    : ${money(r.total)}
BAYAR    : ${money(r.paidAmount)}
KEMBALI  : ${money(r.change)}
METODE   : ${r.paymentMethod}
========================================
Terima kasih telah berbelanja di Jone Bakery!
''';
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Teks struk berhasil disalin ke clipboard!')),
              );
            },
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: navy),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = inventory.where((p) {
      final matchQuery = p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.category.toLowerCase().contains(query.toLowerCase());
      final matchCat = selectedCategory == 'Semua' || p.category == selectedCategory;
      return matchQuery && matchCat;
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 850;

        // Left section: Product Selection
        final productSelection = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Katalog Kasir', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: navy)),
            const SizedBox(height: 6),
            TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Cari roti, pastry, donat...',
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Semua', 'Roti', 'Pastry', 'Donat', 'Kue', 'Minuman'].map((cat) {
                  final isSel = selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSel,
                      selectedColor: navy,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSel ? Colors.white : navy,
                        fontSize: 12,
                        fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (_) => setState(() => selectedCategory = cat),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (ctx, i) {
                  final p = filtered[i];
                  final inCartQty = cart[p] ?? 0;
                  final availableStock = p.stock - inCartQty;

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: ProductThumbnail(
                        imageUrl: p.imageUrl,
                        width: 52,
                        height: 52,
                        borderRadius: 10,
                      ),
                      title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Text(
                        '${money(p.price)}  •  Sisa stok: $availableStock',
                        style: TextStyle(
                          color: availableStock <= 0 ? Colors.red : Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: availableStock > 0 ? navy : Colors.grey.shade400,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onPressed: availableStock > 0 ? () => add(p) : null,
                        child: Text(availableStock > 0 ? '+ Tambah' : 'Habis'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );

        // Right section: Cart, Payment & Checkout
        final cartSection = Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Raised "Keranjang Belanja" with clean spacing
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: creamAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.shopping_bag_outlined, color: navy, size: 18),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Keranjang Belanja',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: navy),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: orange.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${cart.values.fold(0, (s, q) => s + q)} item',
                              style: const TextStyle(color: orange, fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                      if (cart.isNotEmpty)
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red.shade700,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          onPressed: () => setState(() => cart.clear()),
                          icon: const Icon(Icons.delete_sweep_outlined, size: 16),
                          label: const Text('Kosongkan', style: TextStyle(fontSize: 12)),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // Spacious Customer Input Card (No collision with title)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: cream,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: orange.withValues(alpha: 0.28)),
                  ),
                  child: TextField(
                    controller: customerCtrl,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      labelText: 'Nama Pelanggan / Nomor Meja',
                      labelStyle: TextStyle(fontSize: 12.5, color: Colors.black54),
                      prefixIcon: Icon(Icons.person_outline, color: orange, size: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: cart.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 48, color: Colors.black26),
                              SizedBox(height: 8),
                              Text('Keranjang masih kosong', style: TextStyle(color: Colors.black54)),
                              Text('Pilih produk untuk menambahkan', style: TextStyle(fontSize: 12, color: Colors.black38)),
                            ],
                          ),
                        )
                      : ListView(
                          children: cart.entries.map((e) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: cream,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  ProductThumbnail(
                                    imageUrl: e.key.imageUrl,
                                    width: 42,
                                    height: 42,
                                    borderRadius: 8,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.key.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                        Text('${money(e.key.price)} x ${e.value}', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                  Text(money(e.key.price * e.value), style: const TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 13)),
                                  const SizedBox(width: 6),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(Icons.remove_circle_outline, color: orange, size: 22),
                                        onPressed: () => change(e.key, -1),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: Text('${e.value}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(Icons.add_circle, color: navy, size: 22),
                                        onPressed: () => add(e.key),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
                const Divider(),
                // Payment Method
                const Text('Metode Pembayaran:', style: TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 12)),
                const SizedBox(height: 6),
                Row(
                  children: ['Tunai', 'QRIS', 'Transfer'].map((m) {
                    final isSel = paymentMethod == m;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isSel ? navy : Colors.white,
                            foregroundColor: isSel ? Colors.white : navy,
                            side: BorderSide(color: isSel ? navy : Colors.grey.shade300),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () => setState(() => paymentMethod = m),
                          child: Text(m, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                if (paymentMethod == 'Tunai') ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cashPaidCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Uang Diterima (Rp)',
                            hintText: 'Misal: 50000',
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        ),
                        onPressed: () {
                          setState(() {
                            cashPaidCtrl.text = total.toString();
                          });
                        },
                        child: const Text('Uang Pas', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Builder(
                    builder: (ctx) {
                      final input = int.tryParse(cashPaidCtrl.text.replaceAll('.', '').replaceAll('Rp', '')) ?? 0;
                      final change = input - total;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Kembalian:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                          Text(
                            input > 0 && change >= 0 ? money(change) : (input > 0 ? 'Kurang ${money(-change)}' : 'Rp0'),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: change >= 0 ? Colors.green.shade700 : Colors.red,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ] else if (paymentMethod == 'QRIS') ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: creamAccent, borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      children: [
                        Icon(Icons.qr_code_2, color: navy, size: 28),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Scan QRIS Toko Jone Bakery saat pelanggan membayar.',
                            style: TextStyle(fontSize: 11, color: navy),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: creamAccent, borderRadius: BorderRadius.circular(8)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('BCA: 8820-192-111 a.n Jone Bakery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: navy)),
                        Text('Tunjukkan bukti transfer berhasil pada kasir.', style: TextStyle(fontSize: 10, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: creamAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TOTAL:', style: TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 16)),
                      Text(money(total), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: navy)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: navy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: checkout,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('SELESAIKAN TRANSAKSI', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );

        if (isWide) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: productSelection),
                const SizedBox(width: 18),
                Expanded(flex: 2, child: cartSection),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Expanded(flex: 1, child: productSelection),
                const SizedBox(height: 12),
                Expanded(flex: 1, child: cartSection),
              ],
            ),
          );
        }
      },
    );
  }
}

// ---------------------------------------------------------------------------
// 8. TAB 4: MANAJEMEN STOK (INVENTORY & MUTATIONS)
// ---------------------------------------------------------------------------
class StockTab extends StatefulWidget {
  final VoidCallback onChange;

  const StockTab({super.key, required this.onChange});

  @override
  State<StockTab> createState() => _StockTabState();
}

class _StockTabState extends State<StockTab> {
  String filterStatus = 'Semua';
  String query = '';

  Future<void> adjustStock(Product p) async {
    final qtyCtrl = TextEditingController(text: '10');
    final reasonCtrl = TextEditingController(text: 'Restock Produksi Baru');
    bool isAddition = true;

    final success = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: Text(
            'Kelola Stok: ${p.name}',
            style: const TextStyle(color: navy, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Stok saat ini: ${p.stock} pcs', style: const TextStyle(fontWeight: FontWeight.bold, color: orange)),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('+ Tambah Stok'),
                      selected: isAddition,
                      selectedColor: Colors.green.shade700,
                      labelStyle: TextStyle(color: isAddition ? Colors.white : Colors.black87),
                      onSelected: (_) => setDlgState(() => isAddition = true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('- Kurangi Stok'),
                      selected: !isAddition,
                      selectedColor: Colors.red.shade700,
                      labelStyle: TextStyle(color: !isAddition ? Colors.white : Colors.black87),
                      onSelected: (_) => setDlgState(() => isAddition = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: qtyCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Jumlah Perubahan (pcs)'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: reasonCtrl,
                decoration: const InputDecoration(
                  labelText: 'Alasan / Keterangan',
                  hintText: 'Misal: Produksi Baru / Rusak / Expired',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: navy),
              onPressed: () {
                final amount = int.tryParse(qtyCtrl.text);
                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Masukkan jumlah angka yang valid.')),
                  );
                  return;
                }

                final delta = isAddition ? amount : -amount;
                final newStock = p.stock + delta;
                if (newStock < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Stok tidak boleh kurang dari 0.')),
                  );
                  return;
                }

                p.stock = newStock;
                stockMutations.insert(
                  0,
                  StockMutation(
                    id: 'M${DateTime.now().millisecondsSinceEpoch}',
                    productName: p.name,
                    delta: delta,
                    finalStock: p.stock,
                    reason: reasonCtrl.text.trim().isEmpty ? 'Penyesuaian Manual' : reasonCtrl.text.trim(),
                    date: DateTime.now(),
                  ),
                );

                Navigator.pop(ctx, true);
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );

    qtyCtrl.dispose();
    reasonCtrl.dispose();

    if (success == true) {
      widget.onChange();
      setState(() {});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Stok "${p.name}" berhasil diperbarui menjadi ${p.stock} pcs!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalUnits = inventory.fold<int>(0, (sum, p) => sum + p.stock);
    final lowStockItems = inventory.where((p) => p.stock > 0 && p.stock <= 5).toList();
    final outOfStockItems = inventory.where((p) => p.stock == 0).toList();

    final filtered = inventory.where((p) {
      final matchQuery = p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.category.toLowerCase().contains(query.toLowerCase());
      if (filterStatus == 'Stok Menipis') return matchQuery && p.stock > 0 && p.stock <= 5;
      if (filterStatus == 'Stok Habis') return matchQuery && p.stock == 0;
      return matchQuery;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('Manajemen Stok & Gudang', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: navy)),
        const Text('Pantau stok roti, lakukan restock cepat, dan cek riwayat mutasi.', style: TextStyle(color: Colors.black54, fontSize: 13)),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: StatTile(
                title: 'Total Unit Stok',
                value: '$totalUnits pcs',
                icon: Icons.inventory,
                color: navy,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatTile(
                title: 'Stok Menipis (≤5)',
                value: '${lowStockItems.length} item',
                icon: Icons.warning_amber,
                color: orange,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatTile(
                title: 'Stok Habis (0)',
                value: '${outOfStockItems.length} item',
                icon: Icons.cancel_outlined,
                color: Colors.red.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextField(
          onChanged: (v) => setState(() => query = v),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Cari stok produk...',
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: ['Semua', 'Stok Menipis', 'Stok Habis'].map((st) {
            final isSel = filterStatus == st;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(st),
                selected: isSel,
                selectedColor: navy,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(color: isSel ? Colors.white : navy, fontWeight: isSel ? FontWeight.bold : FontWeight.normal),
                onSelected: (_) => setState(() => filterStatus = st),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        ...filtered.map(
          (p) => Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: ProductThumbnail(
                imageUrl: p.imageUrl,
                width: 48,
                height: 48,
                borderRadius: 10,
              ),
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${p.category}  •  Harga: ${money(p.price)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: p.stock == 0
                          ? Colors.red.shade100
                          : (p.stock <= 5 ? Colors.orange.shade100 : Colors.green.shade50),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${p.stock} pcs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: p.stock == 0
                            ? Colors.red.shade900
                            : (p.stock <= 5 ? Colors.orange.shade900 : Colors.green.shade800),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: navy,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    onPressed: () => adjustStock(p),
                    icon: const Icon(Icons.sync, size: 16),
                    label: const Text('Ubah Stok', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Riwayat Mutasi Stok Terbaru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: navy)),
        const SizedBox(height: 8),
        if (stockMutations.isEmpty)
          const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('Belum ada data mutasi stok.')))
        else
          ...stockMutations.take(6).map(
            (m) => Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: m.delta > 0 ? Colors.green.shade50 : Colors.red.shade50,
                  child: Icon(
                    m.delta > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                    color: m.delta > 0 ? Colors.green.shade700 : Colors.red.shade700,
                    size: 20,
                  ),
                ),
                title: Text(m.productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('${m.reason} • ${formatDateTime(m.date)}', style: const TextStyle(fontSize: 12)),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      m.delta > 0 ? '+${m.delta}' : '${m.delta}',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: m.delta > 0 ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                    Text('Sisa: ${m.finalStock} pcs', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 9. TAB 5: LAPORAN & RIWAYAT TRANSAKSI (REPORT)
// ---------------------------------------------------------------------------
class ReportTab extends StatefulWidget {
  const ReportTab({super.key});

  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  String period = 'Semua';
  String query = '';

  List<Receipt> get filteredReceipts {
    final now = DateTime.now();
    return receipts.where((r) {
      bool inPeriod = true;
      if (period == 'Hari Ini') {
        inPeriod = r.date.year == now.year && r.date.month == now.month && r.date.day == now.day;
      } else if (period == 'Bulan Ini') {
        inPeriod = r.date.year == now.year && r.date.month == now.month;
      }

      final matchQuery = r.id.toLowerCase().contains(query.toLowerCase()) ||
          r.customerName.toLowerCase().contains(query.toLowerCase());

      return inPeriod && matchQuery;
    }).toList();
  }

  void viewReceipt(Receipt r) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Detail Transaksi', style: TextStyle(color: navy, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No. Nota: ${r.id}', style: const TextStyle(fontWeight: FontWeight.bold, color: orange)),
              Text('Waktu: ${formatDateTime(r.date)}'),
              Text('Pelanggan: ${r.customerName}'),
              Text('Metode Pembayaran: ${r.paymentMethod}'),
              const Divider(height: 20),
              const Text('Daftar Produk:', style: TextStyle(fontWeight: FontWeight.bold, color: navy)),
              const SizedBox(height: 6),
              ...r.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item.product.name} (${item.qty}x)'),
                      Text(money(item.subtotal), style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, color: navy)),
                  Text(money(r.total), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: navy)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bayar:', style: TextStyle(color: Colors.black54)),
                  Text(money(r.paidAmount)),
                ],
              ),
              if (r.paymentMethod == 'Tunai')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Kembalian:', style: TextStyle(color: Colors.green)),
                    Text(money(r.change), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: navy),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredReceipts;
    final totalRevenue = list.fold<int>(0, (sum, r) => sum + r.total);
    final totalQty = list.fold<int>(0, (sum, r) => sum + r.items.fold<int>(0, (s, i) => s + i.qty));
    final avgOrder = list.isNotEmpty ? (totalRevenue / list.length).round() : 0;

    final cashCount = list.where((r) => r.paymentMethod == 'Tunai').length;
    final qrisCount = list.where((r) => r.paymentMethod == 'QRIS').length;
    final transferCount = list.where((r) => r.paymentMethod == 'Transfer').length;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('Laporan & Riwayat Penjualan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: navy)),
        const Text('Ringkasan omset penjualan dan audit transaksi toko roti.', style: TextStyle(color: Colors.black54, fontSize: 13)),
        const SizedBox(height: 14),
        Row(
          children: ['Semua', 'Hari Ini', 'Bulan Ini'].map((p) {
            final isSel = period == p;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(p),
                selected: isSel,
                selectedColor: navy,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(color: isSel ? Colors.white : navy, fontWeight: isSel ? FontWeight.bold : FontWeight.normal),
                onSelected: (_) => setState(() => period = p),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: StatTile(
                title: 'Total Omset',
                value: money(totalRevenue),
                icon: Icons.payments,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: StatTile(
                title: 'Transaksi',
                value: '${list.length}',
                icon: Icons.receipt_long,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: StatTile(
                title: 'Produk Terjual',
                value: '$totalQty pcs',
                icon: Icons.shopping_bag,
                color: orange,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: StatTile(
                title: 'Rata-rata/Nota',
                value: money(avgOrder),
                icon: Icons.analytics_outlined,
                color: Colors.purple.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // Breakdown metode pembayaran
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, color: navy)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Tunai: $cashCount transaksi', style: const TextStyle(fontSize: 12)),
                    Text('QRIS: $qrisCount transaksi', style: const TextStyle(fontSize: 12)),
                    Text('Transfer: $transferCount transaksi', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Riwayat Transaksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: navy)),
            Text('${list.length} transaksi ditemukan', style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (v) => setState(() => query = v),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Cari nomor nota atau nama pelanggan...',
          ),
        ),
        const SizedBox(height: 10),
        if (list.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: Text('Belum ada transaksi pada periode ini.')),
            ),
          )
        else
          ...list.map(
            (r) => Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: creamAccent,
                  child: Icon(
                    r.paymentMethod == 'Tunai'
                        ? Icons.money
                        : (r.paymentMethod == 'QRIS' ? Icons.qr_code_2 : Icons.account_balance),
                    color: navy,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(money(r.total), style: const TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: creamAccent, borderRadius: BorderRadius.circular(8)),
                      child: Text(r.paymentMethod, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: navy)),
                    ),
                  ],
                ),
                subtitle: Text('${r.id} • ${r.customerName} • ${formatDateTime(r.date)}', style: const TextStyle(fontSize: 12)),
                children: [
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...r.items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item.product.name}  x${item.qty}'),
                                Text(money(item.subtotal), style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              icon: const Icon(Icons.receipt_long, size: 16),
                              label: const Text('Lihat Detail Struk'),
                              onPressed: () => viewReceipt(r),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
