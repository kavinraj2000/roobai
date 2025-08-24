class AllComment {
  String? _id;
  String? _name;
  String? _comment;
  String? _productShortUrl;
  String? _ipAddress;
  String? _date;
  String? _pid;
  String? _productName;
  String? _productImage;
  String? _productSalePrice;
  String? _productOfferPrice;
  String? _productUrl;
  String? _productDescription;
  String? _productStore;
  String? _coupon;
  String? _dealType;
  String? _stockStatus;
  String? _likes;
  String? _dateTime;
  String? _productPageUrl;
  String? _deleteFlag;
  String? _user;
  String? _category;
  String? _subcategory;
  String? _commentCount;
  String? _storeName;
  String? _shareUrl;
  String? _labelText;
  String? _getDealText;
  String? _itext;

  AllComment(
      {String? id,
        String? name,
        String? comment,
        String? productShortUrl,
        String? ipAddress,
        String? date,
        void cdeleteFlag,
        String? pid,
        String? productName,
        String? productImage,
        String? productSalePrice,
        String? productOfferPrice,
        String? productUrl,
        String? productDescription,
        String? productStore,
        String? coupon,
        String? dealType,
        String? stockStatus,
        String? likes,
        String? dateTime,
        void productVariation,
        void productVariationUrl,
        String? productPageUrl,
        String? deleteFlag,
        String? user,
        void tag,
        String? category,
        String? subcategory,
        String? commentCount,
        String? storeName,
        void storeImage,
        String? shareUrl,
        String? labelText,
        String? getDealText,
        String? itext}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (comment != null) {
      _comment = comment;
    }
    if (productShortUrl != null) {
      _productShortUrl = productShortUrl;
    }
    if (ipAddress != null) {
      _ipAddress = ipAddress;
    }
    if (date != null) {
      _date = date;
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
    if (productDescription != null) {
      _productDescription = productDescription;
    }
    if (productStore != null) {
      _productStore = productStore;
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
    if (likes != null) {
      _likes = likes;
    }
    if (dateTime != null) {
      _dateTime = dateTime;
    }

    if (productPageUrl != null) {
      _productPageUrl = productPageUrl;
    }
    if (deleteFlag != null) {
      _deleteFlag = deleteFlag;
    }
    if (user != null) {
      _user = user;
    }

    if (category != null) {
      _category = category;
    }
    if (subcategory != null) {
      _subcategory = subcategory;
    }
    if (commentCount != null) {
      _commentCount = commentCount;
    }
    if (storeName != null) {
      _storeName = storeName;
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

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get comment => _comment;
  set comment(String? comment) => _comment = comment;
  String? get productShortUrl => _productShortUrl;
  set productShortUrl(String? productShortUrl) =>
      _productShortUrl = productShortUrl;
  String? get ipAddress => _ipAddress;
  set ipAddress(String? ipAddress) => _ipAddress = ipAddress;
  String? get date => _date;
  set date(String? date) => _date = date;
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
  String? get productUrl => _productUrl;
  set productUrl(String? productUrl) => _productUrl = productUrl;
  String? get productDescription => _productDescription;
  set productDescription(String? productDescription) =>
      _productDescription = productDescription;
  String? get productStore => _productStore;
  set productStore(String? productStore) => _productStore = productStore;
  String? get coupon => _coupon;
  set coupon(String? coupon) => _coupon = coupon;
  String? get dealType => _dealType;
  set dealType(String? dealType) => _dealType = dealType;
  String? get stockStatus => _stockStatus;
  set stockStatus(String? stockStatus) => _stockStatus = stockStatus;
  String? get likes => _likes;
  set likes(String? likes) => _likes = likes;
  String? get dateTime => _dateTime;
  set dateTime(String? dateTime) => _dateTime = dateTime;



  String? get productPageUrl => _productPageUrl;
  set productPageUrl(String? productPageUrl) =>
      _productPageUrl = productPageUrl;
  String? get deleteFlag => _deleteFlag;
  set deleteFlag(String? deleteFlag) => _deleteFlag = deleteFlag;
  String? get user => _user;
  set user(String? user) => _user = user;

  String? get category => _category;
  set category(String? category) => _category = category;
  String? get subcategory => _subcategory;
  set subcategory(String? subcategory) => _subcategory = subcategory;
  String? get commentCount => _commentCount;
  set commentCount(String? commentCount) => _commentCount = commentCount;
  String? get storeName => _storeName;
  set storeName(String? storeName) => _storeName = storeName;

  String? get shareUrl => _shareUrl;
  set shareUrl(String? shareUrl) => _shareUrl = shareUrl;
  String? get labelText => _labelText;
  set labelText(String? labelText) => _labelText = labelText;
  String? get getDealText => _getDealText;
  set getDealText(String? getDealText) => _getDealText = getDealText;
  String? get itext => _itext;
  set itext(String? itext) => _itext = itext;

  AllComment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _comment = json['comment'];
    _productShortUrl = json['product_short_url'];
    _ipAddress = json['ip_address'];
    _date = json['date'];
    _pid = json['pid'];
    _productName = json['product_name'];
    _productImage = json['product_image'];
    _productSalePrice = json['product_sale_price'];
    _productOfferPrice = json['product_offer_price'];
    _productUrl = json['product_url'];
    _productDescription = json['product_description'];
    _productStore = json['product_store'];
    _coupon = json['coupon'];
    _dealType = json['deal_type'];
    _stockStatus = json['stock_status'];
    _likes = json['likes'];
    _dateTime = json['date_time'];

    _productPageUrl = json['product_page_url'];
    _deleteFlag = json['delete_flag'];
    _user = json['user'];
    _category = json['category'];
    _subcategory = json['subcategory'];
    _commentCount = json['comment_count'];
    _storeName = json['store_name'];
    _shareUrl = json['share_url'];
    _labelText = json['label_text'];
    _getDealText = json['get_deal_text'];
    _itext = json['itext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['comment'] = _comment;
    data['product_short_url'] = _productShortUrl;
    data['ip_address'] = _ipAddress;
    data['date'] = _date;
    data['pid'] = _pid;
    data['product_name'] = _productName;
    data['product_image'] = _productImage;
    data['product_sale_price'] = _productSalePrice;
    data['product_offer_price'] = _productOfferPrice;
    data['product_url'] = _productUrl;
    data['product_description'] = _productDescription;
    data['product_store'] = _productStore;
    data['coupon'] = _coupon;
    data['deal_type'] = _dealType;
    data['stock_status'] = _stockStatus;
    data['likes'] = _likes;
    data['date_time'] = _dateTime;
    data['product_page_url'] = _productPageUrl;
    data['delete_flag'] = _deleteFlag;
    data['user'] = _user;
    data['category'] = _category;
    data['subcategory'] = _subcategory;
    data['comment_count'] = _commentCount;
    data['store_name'] = _storeName;
    data['share_url'] = _shareUrl;
    data['label_text'] = _labelText;
    data['get_deal_text'] = _getDealText;
    data['itext'] = _itext;
    return data;
  }
}