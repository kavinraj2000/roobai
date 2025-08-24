class CmtModel {
  String? rowNumber;
  String? id;
  String? name;
  String? comment;
  String? productShortUrl;
  String? ipAddress;
  String? date;
  String? shareUrl;
  String? labelText;
  String? getDealText;
  String? itext;

  CmtModel(
      {this.rowNumber,
        this.id,
        this.name,
        this.comment,
        this.productShortUrl,
        this.ipAddress,
        this.date,
        this.shareUrl,
        this.labelText,
        this.getDealText,
        this.itext});

  CmtModel.fromJson(Map<String, dynamic> json) {
    rowNumber = json['rowNumber'];
    id = json['id'];
    name = json['name'];
    comment = json['comment'];
    productShortUrl = json['product_short_url'];
    ipAddress = json['ip_address'];
    date = json['date'];
    shareUrl = json['share_url'];
    labelText = json['label_text'];
    getDealText = json['get_deal_text'];
    itext = json['itext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowNumber'] = rowNumber;
    data['id'] = id;
    data['name'] = name;
    data['comment'] = comment;
    data['product_short_url'] = productShortUrl;
    data['ip_address'] = ipAddress;
    data['date'] = date;
    data['share_url'] = shareUrl;
    data['label_text'] = labelText;
    data['get_deal_text'] = getDealText;
    data['itext'] = itext;
    return data;
  }
}