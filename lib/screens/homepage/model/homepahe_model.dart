class ProductModel {
  final String productDescription;
  final String productStore;
  final String pid;
  final String productName;
  final String productImage;
  final String productSalePrice;
  final String productOfferPrice;
  final String productUrl;
  final String coupon;
  final String dealType;
  final String stockStatus;
  final String dateTime;
  final String productShortUrl;
  final String productPageUrl;
  final String storeUrl;
  final String storeImage;
  final String storeName;
  final String commentCount;
  final String likeStatus;
  final String shareUrl;
  final String labelText;
  final String getDealText;
  final String itext;
  final String image1;

  ProductModel({
    required this.productDescription,
    required this.productStore,
    required this.pid,
    required this.productName,
    required this.productImage,
    required this.productSalePrice,
    required this.productOfferPrice,
    required this.productUrl,
    required this.coupon,
    required this.dealType,
    required this.stockStatus,
    required this.dateTime,
    required this.productShortUrl,
    required this.productPageUrl,
    required this.storeUrl,
    required this.storeImage,
    required this.storeName,
    required this.commentCount,
    required this.likeStatus,
    required this.shareUrl,
    required this.labelText,
    required this.getDealText,
    required this.itext,
    required this.image1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productDescription: json['product_description'] ?? '',
      productStore: json['product_store'] ?? '',
      pid: json['pid'] ?? '',
      productName: json['product_name'] ?? '',
      productImage: json['product_image'] ?? '',
      productSalePrice: json['product_sale_price'] ?? '',
      productOfferPrice: json['product_offer_price'] ?? '',
      productUrl: json['product_url'] ?? '',
      coupon: json['coupon'] ?? '',
      dealType: json['deal_type'] ?? '',
      stockStatus: json['stock_status'] ?? '',
      dateTime: json['date_time'] ?? '',
      productShortUrl: json['product_short_url'] ?? '',
      productPageUrl: json['product_page_url'] ?? '',
      storeUrl: json['store_url'] ?? '',
      storeImage: json['store_image'] ?? '',
      storeName: json['store_name'] ?? '',
      commentCount: json['comment_count'] ?? '',
      likeStatus: json['like_status'] ?? '',
      shareUrl: json['share_url'] ?? '',
      labelText: json['label_text'] ?? '',
      getDealText: json['get_deal_text'] ?? '',
      itext: json['itext'] ?? '',
      image1: json['image1'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_description": productDescription,
      "product_store": productStore,
      "pid": pid,
      "product_name": productName,
      "product_image": productImage,
      "product_sale_price": productSalePrice,
      "product_offer_price": productOfferPrice,
      "product_url": productUrl,
      "coupon": coupon,
      "deal_type": dealType,
      "stock_status": stockStatus,
      "date_time": dateTime,
      "product_short_url": productShortUrl,
      "product_page_url": productPageUrl,
      "store_url": storeUrl,
      "store_image": storeImage,
      "store_name": storeName,
      "comment_count": commentCount,
      "like_status": likeStatus,
      "share_url": shareUrl,
      "label_text": labelText,
      "get_deal_text": getDealText,
      "itext": itext,
      "image1": image1,
    };
  }

  ProductModel copyWith({
    String? productDescription,
    String? productStore,
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
    String? labelText,
    String? getDealText,
    String? itext,
    String? image1,
  }) {
    return ProductModel(
      productDescription: productDescription ?? this.productDescription,
      productStore: productStore ?? this.productStore,
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
      labelText: labelText ?? this.labelText,
      getDealText: getDealText ?? this.getDealText,
      itext: itext ?? this.itext,
      image1: image1 ?? this.image1,
    );
  }
}
