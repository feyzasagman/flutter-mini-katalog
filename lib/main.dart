import 'package:flutter/material.dart';

import 'app.dart';
import 'data/product_repository.dart';
import 'state/cart_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ProductRepository repository = ProductRepository();
  await repository.loadProducts();

  final CartState cartState = CartState();

  runApp(
    MiniCatalogApp(
      repository: repository,
      cartState: cartState,
    ),
  );
}
