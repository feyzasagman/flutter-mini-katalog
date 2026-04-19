/// TRY formatı — `intl` paketi kullanılmadan basit gösterim.
String formatMoney(double value) => '${value.toStringAsFixed(2)} ₺';

/// Ürün veri modeli — JSON ile senkron [fromJson] / [toJson].
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.specifications,
  });

  final String id;
  final String title;
  final String category;
  final double price;
  final String description;
  /// `assets/images/products/...` altında yerel görsel dosyası (ör. `headphones.jpg`).
  final String imageUrl;
  final Map<String, String> specifications;

  factory Product.fromJson(Map<String, dynamic> json) {
    final specsRaw = json['specifications'];
    final specs = <String, String>{};
    if (specsRaw is Map<String, dynamic>) {
      specsRaw.forEach((String key, dynamic value) {
        specs[key] = value?.toString() ?? '';
      });
    }

    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      imageUrl: _readImageUrl(json),
      specifications: specs,
    );
  }

  static String _readImageUrl(Map<String, dynamic> json) {
    final Object? v =
        json['imageUrl'] ?? json['image_url'] ?? json['image'] ?? json['photo'];
    if (v == null) {
      return '';
    }
    return v.toString().trim();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'specifications': specifications,
    };
  }
}

extension ProductFormatting on Product {
  /// Türk Lirası — basit gösterim (harici paket yok).
  String get formattedPrice => formatMoney(price);
}
