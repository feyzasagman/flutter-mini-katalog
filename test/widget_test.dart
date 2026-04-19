import 'package:flutter_test/flutter_test.dart';

import 'package:mobil_proje/app.dart';
import 'package:mobil_proje/data/product_repository.dart';
import 'package:mobil_proje/state/cart_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Uygulama açılır ve ana başlık görünür', (WidgetTester tester) async {
    final ProductRepository repository = ProductRepository();
    await repository.loadProducts();

    await tester.pumpWidget(
      MiniCatalogApp(
        repository: repository,
        cartState: CartState(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Teknoloji Mağazası'), findsOneWidget);
    expect(find.textContaining('Teknolojide kampanya'), findsOneWidget);
  });
}
