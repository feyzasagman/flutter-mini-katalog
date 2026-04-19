import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/product.dart';

/// Ürünleri `assets/data/products.json` üzerinden yükler.
class ProductRepository {
  List<Product>? _products;

  Future<void> loadProducts() async {
    final String raw =
        await rootBundle.loadString('assets/data/products.json');
    final dynamic decoded = json.decode(raw);
    if (decoded is! List<dynamic>) {
      throw const FormatException('products.json kök dizisi bekleniyordu.');
    }
    _products = decoded
        .map((dynamic e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  List<Product> get products {
    final List<Product>? list = _products;
    if (list == null) {
      return const <Product>[];
    }
    return List<Product>.unmodifiable(list);
  }

  Product? findById(String id) {
    final List<Product>? list = _products;
    if (list == null) {
      return null;
    }
    for (final Product p in list) {
      if (p.id == id) {
        return p;
      }
    }
    return null;
  }
}
