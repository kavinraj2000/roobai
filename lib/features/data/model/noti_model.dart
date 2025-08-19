class NotiModel {
  String notiProductShortUrl = "";
  String category = "";
  String cat_slug = "";
  int id = 0;
  int time = 0;

  NotiModel({this.notiProductShortUrl = '', this.id = 0, this.time = 0});

  NotiModel.fromJson(Map<String, dynamic> json) {
    notiProductShortUrl = json['noti_product_short_url'];
    category = json['category'];
    cat_slug = json['cat_slug'];
    id = json['id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noti_product_short_url'] = notiProductShortUrl;
    data['id'] = id;
    data['time'] = time;
    data['cat_slug'] = cat_slug;
    data['category'] = category;
    return data;
  }
}
