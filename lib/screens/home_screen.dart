import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import '../theme/app_colors.dart';
import '../theme/breakpoints.dart';
import '../theme/design_tokens.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/home_campaign_banner.dart';
import '../widgets/home_page_backdrop.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/section_title.dart';
import '../widgets/shopping_cart_badge.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

/// Ana sayfa — kampanya banner’ı, arama ve responsive ürün ızgarası.
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.repository,
    required this.cartState,
  });

  final ProductRepository repository;
  final CartState cartState;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredProducts {
    final String q = _query.trim().toLowerCase();
    final List<Product> all = widget.repository.products;
    if (q.isEmpty) {
      return all;
    }
    return all
        .where((Product p) => p.title.toLowerCase().contains(q))
        .toList(growable: false);
  }

  double _gridChildAspectRatio(double width) {
    if (width < 420) {
      return 0.54;
    }
    if (width < 768) {
      return 0.56;
    }
    if (width < 1100) {
      return 0.58;
    }
    return 0.60;
  }

  Future<void> _openCart() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => CartScreen(
          cartState: widget.cartState,
        ),
      ),
    );
  }

  Future<void> _openProduct(Product product) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ProductDetailScreen(
          product: product,
          cartState: widget.cartState,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<Product> visible = _filteredProducts;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Teknoloji Mağazası'),
        actions: <Widget>[
          ListenableBuilder(
            listenable: widget.cartState,
            builder: (BuildContext context, Widget? child) {
              final int count = widget.cartState.totalUnits;
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    IconButton(
                      tooltip: 'Sepet',
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      onPressed: _openCart,
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: scheme.primary,
                      ),
                    ),
                    if (count > 0)
                      Positioned(
                        right: 2,
                        top: 4,
                        child: ShoppingCartBadge(count: count),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Positioned.fill(child: HomePageBackdrop()),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double viewportW = constraints.maxWidth;
              final double gutter =
                  AppBreakpoints.contentHorizontalGutter(viewportW);
              final double ratio = _gridChildAspectRatio(viewportW);

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: gutter),
                child: CustomScrollView(
                  slivers: <Widget>[
                    const SliverToBoxAdapter(
                      child: HomeCampaignBanner(),
                    ),
                    const SliverToBoxAdapter(child: HomeBannerSoftFade()),
                    SliverToBoxAdapter(
                      child: SearchBarWidget(
                        controller: _searchController,
                        hintText: 'Ürün adına göre arama yapın',
                        onChanged: (String value) =>
                            setState(() => _query = value),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SectionTitle(
                        title: 'Ürün koleksiyonu',
                        subtitle:
                            'Günlük kullanım için seçilmiş popüler teknoloji ürünleri',
                      ),
                    ),
                    if (visible.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          icon: Icons.search_off_rounded,
                          title: 'Arama sonucu bulunamadı',
                          message:
                              'Arama kriterlerinize uygun bir ürün olmadı. Anahtar kelimeyi değiştirip yeniden deneyebilirsiniz.',
                          action: FilledButton.tonalIcon(
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Aramayı temizle'),
                          ),
                        ),
                      )
                    else
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.lg,
                            AppSpacing.sm,
                            AppSpacing.lg,
                            AppSpacing.xxl + 8,
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppPalette.surfaceSection,
                              borderRadius:
                                  BorderRadius.circular(AppRadii.lg),
                              border: Border.all(
                                color: AppPalette.border
                                    .withValues(alpha: 0.72),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppPalette.primary
                                      .withValues(alpha: 0.035),
                                  blurRadius: 28,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                AppSpacing.md,
                                AppSpacing.lg,
                                AppSpacing.md,
                                AppSpacing.lg + 4,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      AppBreakpoints.gridCrossAxisCount(
                                    viewportW,
                                  ),
                                  mainAxisSpacing: AppSpacing.lg,
                                  crossAxisSpacing: AppSpacing.lg,
                                  childAspectRatio: ratio,
                                ),
                                itemCount: visible.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Product product = visible[index];
                                  return ProductCard(
                                    product: product,
                                    onTap: _openProduct,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
