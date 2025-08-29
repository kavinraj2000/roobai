class Product {
  final String? pid;
  final String? productName;
  final String? productImage;
  final String? productSalePrice;
  final String? productOfferPrice;
  final String? productUrl;
  final String? coupon;
  final String? dealType;
  final String? stockStatus;
  final String? dateTime;
  final String? productShortUrl;
  final String? productPageUrl;
  final String? storeUrl;
  final String? storeImage;
  final String? storeName;
  final String? commentCount;
  final String? likeStatus;
  final String? shareUrl;
  final String? productDescription;

  Product({
    this.pid,
    this.productName,
    this.productImage,
    this.productSalePrice,
    this.productOfferPrice,
    this.productUrl,
    this.coupon,
    this.dealType,
    this.stockStatus,
    this.dateTime,
    this.productShortUrl,
    this.productPageUrl,
    this.storeUrl,
    this.storeImage,
    this.storeName,
    this.commentCount,
    this.likeStatus,
    this.shareUrl,
    this.productDescription,
  });

  /// ✅ FROM JSON / Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      pid: map['pid'],
      productName: map['product_name'],
      productImage: map['product_image'],
      productSalePrice: map['product_sale_price'],
      productOfferPrice: map['product_offer_price'],
      productUrl: map['product_url'],
      coupon: map['coupon'],
      dealType: map['deal_type'],
      stockStatus: map['stock_status'],
      dateTime: map['date_time'],
      productShortUrl: map['product_short_url'],
      productPageUrl: map['product_page_url'],
      storeUrl: map['store_url'],
      storeImage: map['store_image'],
      storeName: map['store_name'],
      commentCount: map['comment_count'],
      likeStatus: map['like_status'],
      shareUrl: map['share_url'],
      productDescription: map['product_description'],
    );
  }

  /// ✅ TO JSON / Map
  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'product_name': productName,
      'product_image': productImage,
      'product_sale_price': productSalePrice,
      'product_offer_price': productOfferPrice,
      'product_url': productUrl,
      'coupon': coupon,
      'deal_type': dealType,
      'stock_status': stockStatus,
      'date_time': dateTime,
      'product_short_url': productShortUrl,
      'product_page_url': productPageUrl,
      'store_url': storeUrl,
      'store_image': storeImage,
      'store_name': storeName,
      'comment_count': commentCount,
      'like_status': likeStatus,
      'share_url': shareUrl,
      'product_description': productDescription,
    };
  }

  /// ✅ copyWith
  Product copyWith({
    String? pid,
    String? productName,
    String? productImage,
    String? productSalePrice,
    String? productOfferPrice,
    String? productUrl,
    String? coupon,
    String? dealType,
    String? stockStatus,
    String? dateTime,
    String? productShortUrl,
    String? productPageUrl,
    String? storeUrl,
    String? storeImage,
    String? storeName,
    String? commentCount,
    String? likeStatus,
    String? shareUrl,
    String? productDescription,
  }) {
    return Product(
      pid: pid ?? this.pid,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productSalePrice: productSalePrice ?? this.productSalePrice,
      productOfferPrice: productOfferPrice ?? this.productOfferPrice,
      productUrl: productUrl ?? this.productUrl,
      coupon: coupon ?? this.coupon,
      dealType: dealType ?? this.dealType,
      stockStatus: stockStatus ?? this.stockStatus,
      dateTime: dateTime ?? this.dateTime,
      productShortUrl: productShortUrl ?? this.productShortUrl,
      productPageUrl: productPageUrl ?? this.productPageUrl,
      storeUrl: storeUrl ?? this.storeUrl,
      storeImage: storeImage ?? this.storeImage,
      storeName: storeName ?? this.storeName,
      commentCount: commentCount ?? this.commentCount,
      likeStatus: likeStatus ?? this.likeStatus,
      shareUrl: shareUrl ?? this.shareUrl,
      productDescription: productDescription ?? this.productDescription,
    );
  }

  /// ✅ Optional: Debug log
  @override
  String toString() {
    return 'Product(pid: $pid, productName: $productName, likeStatus: $likeStatus)';
  }
}
