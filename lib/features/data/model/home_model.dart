class HomeModel {
  String? title;
  String? cat_slug;
  String? type;
  List<Data>? data;

  HomeModel({this.title, this.type, this.data, this.cat_slug});

  HomeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cat_slug = json['cat_slug'];
    type = json['type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['cat_slug'] = cat_slug;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? bannerId;
  String? bannerName;
  String? url;
  String? product_url;
  String? image;
  String? image1;
  String? type;
  String? flag;
  String? filler1;
  String? filler2;
  String? filler3;
  String? filler4;
  String? created;
  String? createdby;
  String? modified;
  String? modifiedby;
  String? productImage;
  String? storeImage;
  String? store_url;
  String? shareUrl;
  String? productName;
  String? labelText;
  String? getDealText;
  String? itext;
  String? category;
  String? cat_slug;
  String? category_image;
  String? productOfferPrice;
  String? productSalePrice;
  String? dateTime;
  String? storeName;
  String? img_url;

  Data(
      {this.bannerId,
      this.bannerName,
      this.url,
      this.product_url,
      this.image,
      this.type,
      this.flag,
      this.filler1,
      this.filler2,
      this.store_url,
      this.filler3,
      this.filler4,
      this.created,
      this.image1,
      this.createdby,
      this.modified,
      this.modifiedby,
      this.productImage,
      this.storeImage,
      this.shareUrl,
      this.productName,
      this.labelText,
      this.category_image,
      this.getDealText,
      this.category,
      this.cat_slug,
      this.productOfferPrice,
      this.productSalePrice,
      this.dateTime,
      this.storeName,
      this.img_url,
      this.itext});

  Data.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    url = json['url'];
    product_url = json['product_url'];
    image = json['image'];
    type = json['type'];
    flag = json['flag'];
    filler1 = json['filler1'];
    filler2 = json['filler2'];
    store_url = json['store_url'];
    filler3 = json['filler3'];
    filler4 = json['filler4'];
    created = json['created'];
    createdby = json['createdby'];
    modified = json['modified'];
    modifiedby = json['modifiedby'];
    productImage = json['product_image'];
    storeImage = json['store_image'];
    shareUrl = json['share_url'];
    productName = json['product_name'];
    category_image = json['category_image'];
    labelText = json['label_text'];
    getDealText = json['get_deal_text'];
    image1 = json['image1'];
    itext = json['itext'];
    productSalePrice = json['product_sale_price'];
    productOfferPrice = json['product_offer_price'];
    dateTime = json['date_time'];
    category = json['category'];
    cat_slug = json['cat_slug'];
    storeName = json['store_name'];
    img_url = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['banner_name'] = bannerName;
    data['url'] = url;
    data['product_url'] = product_url;
    data['image'] = image;
    data['type'] = type;
    data['store_url'] = store_url;
    data['flag'] = flag;
    data['filler1'] = filler1;
    data['filler2'] = filler2;
    data['filler3'] = filler3;
    data['filler4'] = filler4;
    data['created'] = created;
    data['createdby'] = createdby;
    data['modified'] = modified;
    data['modifiedby'] = modifiedby;
    data['product_image'] = productImage;
    data['store_image'] = storeImage;
    data['share_url'] = shareUrl;
    data['product_name'] = productName;
    data['label_text'] = labelText;
    data['get_deal_text'] = getDealText;
    data['itext'] = itext;
    data['image1'] = image1;
    data['product_offer_price'] = productOfferPrice;
    data['product_sale_price'] = productSalePrice;
    data['category'] = category;
    data['cat_slug'] = cat_slug;
    data['category_image'] = category_image;
    data['date_time'] = dateTime;
    data['store_name'] = storeName;
    data['img_url'] = img_url;
    return data;
  }
}
