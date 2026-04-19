<<<<<<< HEAD
# Mini Katalog Uygulaması

Flutter ile geliştirilmiş, eğitim amaçlı mini ürün katalog ve sepet uygulaması. Ürünler JSON varlığından okunur; ana sayfa, ürün detayı ve sepet akışı tamamlanmıştır.

## Flutter sürümü

Bu proje şu Flutter sürümü ile uyumludur: **`>=3.24.0`** (yer tutucu — kurulumunuzdaki `flutter --version` çıktısına göre güncelleyin).

SDK gereksinimi `pubspec.yaml` içinde `>=3.0.0 <4.0.0` olarak tanımlıdır.

## Projeyi çalıştırma

1. [Flutter SDK](https://docs.flutter.dev/get-started/install) kurulu olduğundan emin olun.
2. Proje kök dizinine gidin:

   ```bash
   cd mobil_proje
   ```

3. Bağımlılıkları alın:

   ```bash
   flutter pub get
   ```

4. Cihaz veya emülatör seçip çalıştırın:

   ```bash
   flutter run
   ```

**Not:** Proje kökünde henüz `android/` veya `ios/` klasörleri yoksa, Flutter ortamınızda bir kez şu komutla platform şablonlarını ekleyebilirsiniz (mevcut `lib/` ve `pubspec.yaml` korunur; çakışma uyarısı çıkarsa birleştirmeniz gerekebilir):

```bash
flutter create .
```

## Proje yapısı (özet)

| Konum | Açıklama |
| --- | --- |
| `lib/main.dart` | Giriş noktası, asset yükleme ve `runApp` |
| `lib/app.dart` | `MaterialApp`, tema ve ana rota |
| `lib/models/` | `Product`, `CartItem`, JSON serileştirme |
| `lib/data/product_repository.dart` | `products.json` okuma |
| `lib/state/cart_state.dart` | `ChangeNotifier` ile sepet durumu |
| `lib/screens/` | Ana sayfa, detay, sepet |
| `lib/widgets/` | Kart, arama, boş durum, bölüm başlığı |
| `lib/utils/app_theme.dart` | Tema ve bileşen stilleri |
| `assets/data/products.json` | Ürün verisi |

## Özellikler

- JSON tabanlı ürün listesi (en az 8 ürün), `fromJson` / `toJson`
- Ana sayfa: AppBar, yerel gradient banner, arama ile ada göre filtreleme, grid ürün kartları
- Ürün detayı: görsel, fiyat, açıklama, özellik tablosu, sepete ekleme
- Sepet: adet artır/azalt, satır silme, toplam tutar, boş sepet ekranı (Türkçe)
- Harici state management paketi yok — `ChangeNotifier` + `ListenableBuilder`
- Yalnızca `flutter` / `dart` ve `material.dart`; ek paket yok

## Ekran görüntüleri

> **Yer tutucu:** Aşağıya çalışan uygulamadan aldığınız ekran görüntülerini ekleyin.

### Ana sayfa

_(Buraya ana sayfa ekran görüntüsü)_

### Ürün detayı

_(Buraya ürün detay ekran görüntüsü)_

### Sepet

_(Buraya sepet ekran görüntüsü)_
=======
# flutter-mini-katalog
>>>>>>> c3cc2f901db70a1662e2f9a7913c585a521a8f56
