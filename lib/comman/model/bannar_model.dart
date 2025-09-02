import 'package:equatable/equatable.dart';
import 'dart:convert';

class BannerModel extends Equatable {
  final String? bannerId;
  final String? bannerName;
  final String? url;
  final String? image;
  final String? type;
  final String? flag;
  final String? site;

  const BannerModel({
    this.bannerId,
    this.bannerName,
    this.url,
    this.image,
    this.type,
    this.flag,
    this.site,
  });

  BannerModel copyWith({
    String? bannerId,
    String? bannerName,
    String? url,
    String? image,
    String? type,
    String? flag,
    String? site,
  }) {
    return BannerModel(
      bannerId: bannerId ?? this.bannerId,
      bannerName: bannerName ?? this.bannerName,
      url: url ?? this.url,
      image: image ?? this.image,
      type: type ?? this.type,
      flag: flag ?? this.flag,
      site: site ?? this.site,
    );
  }

  // From JSON
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerId: json['banner_id']?.toString(),
      bannerName: json['banner_name'],
      url: json['url'],
      image: json['image'],
      type: json['type'],
      flag: json['flag'],
      site: json['site'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'banner_id': bannerId,
      'banner_name': bannerName,
      'url': url,
      'image': image,
      'type': type,
      'flag': flag,
      'site': site,
    };
  }

  @override
  List<Object?> get props => [
    bannerId,
    bannerName,
    url,
    image,
    type,
    flag,
    site,
  ];

  @override
  String toString() => jsonEncode(toJson());
}
