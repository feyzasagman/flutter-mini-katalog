import 'package:flutter/material.dart';

import 'data/product_repository.dart';
import 'screens/home_screen.dart';
import 'state/cart_state.dart';
import 'utils/app_theme.dart';

/// Kök Material uygulama kabuğu.
class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({
    super.key,
    required this.repository,
    required this.cartState,
  });

  final ProductRepository repository;
  final CartState cartState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teknoloji Mağazası',
      theme: AppTheme.light,
      home: HomeScreen(
        repository: repository,
        cartState: cartState,
      ),
    );
  }
}
