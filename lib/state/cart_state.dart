import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

/// Paketsiz sepet durumu — [ChangeNotifier] + [ListenableBuilder] ile bağlanır.
class CartState extends ChangeNotifier {
  final List<CartItem> _items = <CartItem>[];

  List<CartItem> get items => List<CartItem>.unmodifiable(_items);

  int get distinctCount => _items.length;

  int quantityFor(String productId) {
    final int index = _indexOfProduct(productId);
    if (index < 0) {
      return 0;
    }
    return _items[index].quantity;
  }

  int get totalUnits {
    int sum = 0;
    for (final CartItem i in _items) {
      sum += i.quantity;
    }
    return sum;
  }

  double get totalPrice {
    double sum = 0;
    for (final CartItem i in _items) {
      sum += i.lineTotal;
    }
    return sum;
  }

  bool get isEmpty => _items.isEmpty;

  void addProduct(Product product) {
    final int index = _indexOfProduct(product.id);
    if (index >= 0) {
      final CartItem current = _items[index];
      _items[index] = current.copyWith(quantity: current.quantity + 1);
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    final int index = _indexOfProduct(productId);
    if (index < 0) {
      return;
    }
    final CartItem current = _items[index];
    _items[index] = current.copyWith(quantity: current.quantity + 1);
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    final int index = _indexOfProduct(productId);
    if (index < 0) {
      return;
    }
    final CartItem current = _items[index];
    if (current.quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index] = current.copyWith(quantity: current.quantity - 1);
    }
    notifyListeners();
  }

  void removeLine(String productId) {
    final int index = _indexOfProduct(productId);
    if (index < 0) {
      return;
    }
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    if (_items.isEmpty) {
      return;
    }
    _items.clear();
    notifyListeners();
  }

  int _indexOfProduct(String productId) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].product.id == productId) {
        return i;
      }
    }
    return -1;
  }
}
