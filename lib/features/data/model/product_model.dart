class ProductModel {
  String? _productDescription;
  String? _productStore;
  String? _pid;
  String? _productName;
  String? _productImage;
  String? _productSalePrice;
  String? _productOfferPrice;
  String? _productUrl;
  String? _coupon;
  String? _dealType;
  String? _stockStatus;
  String? _dateTime;
  String? _productShortUrl;
  String? _productPageUrl;
  String? _storeUrl;
  String? _storeImage;
  String? _storeName;
  String? _commentCount;
  String? _likeStatus;
  String? _shareUrl;
  String? _labelText;
  String? _getDealText;
  String? _itext;
  String? _come_for;

  ProductModel(
      {String? productDescription,
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
        String? come_for,
        String? itext}) {
    if (productDescription != null) {
      _productDescription = productDescription;
    }

    if (come_for != null) {
      _come_for = come_for;
    }
    if (productStore != null) {
      _productStore = productStore;
    }
    if (pid != null) {
      _pid = pid;
    }
    if (productName != null) {
      _productName = productName;
    }
    if (productImage != null) {
      _productImage = productImage;
    }
    if (productSalePrice != null) {
      _productSalePrice = productSalePrice;
    }
    if (productOfferPrice != null) {
      _productOfferPrice = productOfferPrice;
    }
    if (productUrl != null) {
      _productUrl = productUrl;
    }
    if (coupon != null) {
      _coupon = coupon;
    }
    if (dealType != null) {
      _dealType = dealType;
    }
    if (stockStatus != null) {
      _stockStatus = stockStatus;
    }
    if (dateTime != null) {
      _dateTime = dateTime;
    }
    if (productShortUrl != null) {
      _productShortUrl = productShortUrl;
    }
    if (productPageUrl != null) {
      _productPageUrl = productPageUrl;
    }
    if (storeUrl != null) {
      _storeUrl = storeUrl;
    }
    if (storeImage != null) {
      _storeImage = storeImage;
    }
    if (storeName != null) {
      _storeName = storeName;
    }
    if (commentCount != null) {
      _commentCount = commentCount;
    }
    if (likeStatus != null) {
      _likeStatus = likeStatus;
    }
    if (shareUrl != null) {
      _shareUrl = shareUrl;
    }
    if (labelText != null) {
      _labelText = labelText;
    }
    if (getDealText != null) {
      _getDealText = getDealText;
    }
    if (itext != null) {
      _itext = itext;
    }
  }

  String? get productDescription => _productDescription;
  set productDescription(String? productDescription) =>
      _productDescription = productDescription;
  String? get productStore => _productStore;
  set productStore(String? productStore) => _productStore = productStore;
  String? get pid => _pid;
  set pid(String? pid) => _pid = pid;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  String? get productImage => _productImage;
  set productImage(String? productImage) => _productImage = productImage;
  String? get productSalePrice => _productSalePrice;
  set productSalePrice(String? productSalePrice) =>
      _productSalePrice = productSalePrice;
  String? get productOfferPrice => _productOfferPrice;
  set productOfferPrice(String? productOfferPrice) =>
      _productOfferPrice = productOfferPrice;
  String? get
  productUrl => _productUrl;
  set productUrl(String? productUrl) => _productUrl = productUrl;
  String? get coupon => _coupon;
  set coupon(String? coupon) => _coupon = coupon;
  String? get dealType => _dealType;
  set dealType(String? dealType) => _dealType = dealType;
  String? get stockStatus => _stockStatus;
  set stockStatus(String? stockStatus) => _stockStatus = stockStatus;
  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;
  String? get productShortUrl => _productShortUrl;
  set productShortUrl(String? productShortUrl) =>
      _productShortUrl = productShortUrl;
  String? get productPageUrl => _productPageUrl;
  set productPageUrl(String? productPageUrl) =>
      _productPageUrl = productPageUrl;
  String? get storeUrl => _storeUrl;
  set storeUrl(String? storeUrl) => _storeUrl = storeUrl;
  String? get storeImage => _storeImage;
  set storeImage(String? storeImage) => _storeImage = storeImage;
  String? get storeName => _storeName;
  set storeName(String? storeName) => _storeName = storeName;
  String? get commentCount => _commentCount;
  set commentCount(String? commentCount) => _commentCount = commentCount;
  String? get likeStatus => _likeStatus;
  set likeStatus(String? likeStatus) => _likeStatus = likeStatus;
  String? get shareUrl => _shareUrl;
  set shareUrl(String? shareUrl) => _shareUrl = shareUrl;
  String? get labelText => _labelText;
  set labelText(String? labelText) => _labelText = labelText;
  String? get getDealText => _getDealText;
  set getDealText(String? getDealText) => _getDealText = getDealText;
  String? get itext => _itext;
  set itext(String? itext) => _itext = itext;

  String? get come_for => _come_for;
  set come_for(String? comeFor) => _come_for = comeFor;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _productDescription = json['product_description'];
    _productStore = json['product_store'];
    _pid = json['pid'];
    _productName = json['product_name'];
    _productImage = json['product_image'];
    _productSalePrice = json['product_sale_price'];
    _productOfferPrice = json['product_offer_price'];
    _productUrl = json['product_url'];
    _coupon = json['coupon'];
    _dealType = json['deal_type'];
    _stockStatus = json['stock_status'];
    _dateTime = json['date_time'];
    _productShortUrl = json['product_short_url'];
    _productPageUrl = json['product_page_url'];
    _storeUrl = json['store_url'];
    _storeImage = json['store_image'];
    _storeName = json['store_name'];
    _commentCount = json['comment_count'];
    _likeStatus = json['like_status'];
    _shareUrl = json['share_url'];
    _labelText = json['label_text'];
    _getDealText = json['get_deal_text'];
    _itext = json['itext'];
    _come_for = json['come_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_description'] = _productDescription;
    data['product_store'] = _productStore;
    data['pid'] = _pid;
    data['product_name'] = _productName;
    data['product_image'] = _productImage;
    data['product_sale_price'] = _productSalePrice;
    data['product_offer_price'] = _productOfferPrice;
    data['product_url'] = _productUrl;
    data['coupon'] = _coupon;
    data['deal_type'] = _dealType;
    data['stock_status'] = _stockStatus;
    data['date_time'] = _dateTime;
    data['product_short_url'] = _productShortUrl;
    data['product_page_url'] = _productPageUrl;
    data['store_url'] = _storeUrl;
    data['store_image'] = _storeImage;
    data['store_name'] = _storeName;
    data['comment_count'] = _commentCount;
    data['like_status'] = _likeStatus;
    data['share_url'] = _shareUrl;
    data['label_text'] = _labelText;
    data['get_deal_text'] = _getDealText;
    data['itext'] = _itext;
    data['come_for'] = _come_for;
    return data;
  }
}