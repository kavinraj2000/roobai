class BaseModel {
  String? website;
  String? iosVersion;
  String? androidVersion;
  String? baseApiUrl;
  String? ios_base_api_url;
  String? giveawayToken;
  String? refcode1;
  String? refcode2;
  String? reftitle;
  String? affiliateDisclosure;
  String? banner;
  String? bannerUrl1;
  String? bannerImage1;

  BaseModel(
      {this.website,
        this.iosVersion,
        this.androidVersion,
        this.baseApiUrl,
        this.ios_base_api_url,
        this.giveawayToken,
        this.refcode1,
        this.refcode2,
        this.reftitle,
        this.affiliateDisclosure,
        this.banner,
        this.bannerUrl1,
        this.bannerImage1});

  BaseModel.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    iosVersion = json['ios_version'];
    androidVersion = json['android_version'];
    baseApiUrl = json['base_api_url'];
    ios_base_api_url = json['ios_base_api_url'];
    giveawayToken = json['giveaway_token'];
    refcode1 = json['refcode1'];
    refcode2 = json['refcode2'];
    reftitle = json['reftitle'];
    affiliateDisclosure = json['affiliate_disclosure'];
    banner = json['banner'];
    bannerUrl1 = json['banner_url_1'];
    bannerImage1 = json['banner_image_1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['website'] = website;
    data['ios_version'] = iosVersion;
    data['android_version'] = androidVersion;
    data['base_api_url'] = baseApiUrl;
    data['ios_base_api_url'] = ios_base_api_url;
    data['giveaway_token'] = giveawayToken;
    data['refcode1'] = refcode1;
    data['refcode2'] = refcode2;
    data['reftitle'] = reftitle;
    data['affiliate_disclosure'] = affiliateDisclosure;
    data['banner'] = banner;
    data['banner_url_1'] = bannerUrl1;
    data['banner_image_1'] = bannerImage1;
    return data;
  }
}