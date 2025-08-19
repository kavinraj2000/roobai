class PriceFormatter {
  static String formatPrice(dynamic price) {
    if (price == null) return "N/A";
    final priceValue = double.tryParse(price.toString()) ?? 0;
    if (priceValue >= 100000) {
      return "${(priceValue / 100000).toStringAsFixed(1)}L";
    } else if (priceValue >= 1000) {
      return "${(priceValue / 1000).toStringAsFixed(1)}K";
    }
    return priceValue.toStringAsFixed(0);
  }
}