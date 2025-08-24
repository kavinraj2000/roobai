class DealModel {
  String? status;
  String? title1;
  String? title2;
  List<Providers>? providers;
  List<DealCat>? dealCat;

  DealModel(
      {this.status, this.title1, this.title2, this.providers, this.dealCat});

  DealModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    title1 = json['title1'];
    title2 = json['title2'];
    if (json['providers'] != null) {
      providers = <Providers>[];
      json['providers'].forEach((v) {
        providers!.add(new Providers.fromJson(v));
      });
    }
    if (json['deal_cat'] != null) {
      dealCat = <DealCat>[];
      json['deal_cat'].forEach((v) {
        dealCat!.add(new DealCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['title1'] = this.title1;
    data['title2'] = this.title2;
    if (this.providers != null) {
      data['providers'] = this.providers!.map((v) => v.toJson()).toList();
    }
    if (this.dealCat != null) {
      data['deal_cat'] = this.dealCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
String toString() {
  return 'DealModel(status: $status, title1: $title1, title2: $title2, '
         'providers: $providers, dealCat: $dealCat)';
}

}

class Providers {
  String? title;
  String? image;
  String? text;
  String? type;
  String? selected;
  String? gift;

  Providers({this.title, this.image, this.text, this.type, this.gift, this.selected});

  Providers.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    text = json['text'];
    type = json['type'];
    gift = json['gift'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['text'] = this.text;
    data['type'] = this.type;
    data['gift'] = this.gift;
    data['selected'] = this.selected;
    return data;
  }
  @override
String toString() {
  return 'Providers(title: $title, image: $image, text: $text, type: $type, '
         'gift: $gift, selected: $selected)';
}

}

class DealCat {
  String? category;
  String? parentid;
  String? categoryid;

  DealCat({this.category, this.parentid, this.categoryid});

  DealCat.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    parentid = json['parentid'];
    categoryid = json['categoryid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['parentid'] = this.parentid;
    data['categoryid'] = this.categoryid;
    return data;
  }

@override
String toString() {
  return 'DealCat(category: $category, parentid: $parentid, categoryid: $categoryid)';
}


}