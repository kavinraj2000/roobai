class BaseModel {
  String? website;
  String? iosVersion;
  String? androidVersion;
  String? baseApiUrl;
  String? iosBaseApiUrl; // Changed from ios_base_api_url to follow camelCase
  String? giveawayToken;
  String? refcode1;
  String? refcode2;
  String? reftitle;
  String? affiliateDisclosure;
  String? banner;
  String? bannerUrl1;
  String? bannerImage1;

  BaseModel({
    this.website,
    this.iosVersion,
    this.androidVersion,
    this.baseApiUrl,
    this.iosBaseApiUrl,
    this.giveawayToken,
    this.refcode1,
    this.refcode2,
    this.reftitle,
    this.affiliateDisclosure,
    this.banner,
    this.bannerUrl1,
    this.bannerImage1,
  });

  BaseModel.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    iosVersion = json['ios_version'];
    androidVersion = json['android_version'];
    baseApiUrl = json['base_api_url'];
    iosBaseApiUrl = json['ios_base_api_url']; // JSON key stays the same
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
    data['ios_base_api_url'] = iosBaseApiUrl; // JSON key stays the same
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

  @override
  String toString() {
    return 'BaseModel(website: $website, iosVersion: $iosVersion, androidVersion: $androidVersion, baseApiUrl: $baseApiUrl, iosBaseApiUrl: $iosBaseApiUrl, giveawayToken: $giveawayToken, refcode1: $refcode1, refcode2: $refcode2, reftitle: $reftitle, affiliateDisclosure: $affiliateDisclosure, banner: $banner, bannerUrl1: $bannerUrl1, bannerImage1: $bannerImage1)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BaseModel &&
      other.website == website &&
      other.iosVersion == iosVersion &&
      other.androidVersion == androidVersion &&
      other.baseApiUrl == baseApiUrl &&
      other.iosBaseApiUrl == iosBaseApiUrl &&
      other.giveawayToken == giveawayToken &&
      other.refcode1 == refcode1 &&
      other.refcode2 == refcode2 &&
      other.reftitle == reftitle &&
      other.affiliateDisclosure == affiliateDisclosure &&
      other.banner == banner &&
      other.bannerUrl1 == bannerUrl1 &&
      other.bannerImage1 == bannerImage1;
  }

  @override
  int get hashCode {
    return website.hashCode ^
      iosVersion.hashCode ^
      androidVersion.hashCode ^
      baseApiUrl.hashCode ^
      iosBaseApiUrl.hashCode ^
      giveawayToken.hashCode ^
      refcode1.hashCode ^
      refcode2.hashCode ^
      reftitle.hashCode ^
      affiliateDisclosure.hashCode ^
      banner.hashCode ^
      bannerUrl1.hashCode ^
      bannerImage1.hashCode;
  }
}