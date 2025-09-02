import 'dart:convert';

class CategoryModel {
  String? cid;
  String? category;
  String? categoryImage;
  String? type;
  String? sort;
  String? flag;
  String? cat_slug;
  String? url;

  CategoryModel(
      {this.cid,
        this.category,
        this.categoryImage,
        this.type,
        this.sort,
        this.cat_slug,
        this.url,
        this.flag});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    url = json['url'];
    category = json['category'];
    categoryImage = json['category_image'];
    type = json['type'];
    sort = json['sort'];
    cat_slug = json['cat_slug'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cid'] = cid;
    data['category'] = category;
    data['category_image'] = categoryImage;
    data['type'] = type;
    data['sort'] = sort;
    data['cat_slug'] = cat_slug;
    data['flag'] = flag;
    data['url'] = url;
    return data;
  }
    @override

    String toString() => jsonEncode(toJson());

}