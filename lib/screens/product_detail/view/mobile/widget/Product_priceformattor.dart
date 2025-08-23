class PriceFormatter {
  static String formatPrice(dynamic price) {
    if (price == null) return '0';
    final numPrice = double.tryParse(price.toString()) ?? 0.0;
    return numPrice.toStringAsFixed(2);
  }
}