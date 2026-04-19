/// Responsive ızgara ve içerik genişliği kırılımları.
abstract final class AppBreakpoints {
  static const double tablet = 600;
  static const double laptop = 1024;
  static const double wide = 1400;
  static const double contentMaxWidth = 1320;

  /// Mobil 2 • Tablet 3 • Laptop 4 • Geniş ekran 5.
  static int gridCrossAxisCount(double width) {
    if (width >= wide) {
      return 5;
    }
    if (width >= laptop) {
      return 4;
    }
    if (width >= tablet) {
      return 3;
    }
    return 2;
  }

  static double contentHorizontalGutter(double viewportWidth) {
    if (viewportWidth <= contentMaxWidth) {
      return 0;
    }
    return (viewportWidth - contentMaxWidth) / 2;
  }
}
