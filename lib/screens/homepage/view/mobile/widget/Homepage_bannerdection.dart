import 'package:flutter/material.dart';
import 'package:roobai/comman/model/home_model.dart';

class BannerSection extends StatelessWidget {
  final List<Data> banners;

  const BannerSection({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          // final imageUrl = _getBannerImage(banner);
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                if (banner.url != null && banner.url!.isNotEmpty) {
                  print("Banner tapped - URL: ${banner.url}");
                }
              },
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: imageUrl != null
              //       ? Image.network(imageUrl, fit: BoxFit.cover)
              //       : const Placeholder(fallbackHeight: 180),
              // ),
            ),
          );
        },
      ),
    );
  }

  // String? _getBannerImage(Data banner) {
  //   if (banner.image1?.isNotEmpty == true) return banner.image1!;
  //   if (banner.image?.isNotEmpty == true) {
  //     if (!banner.image!.startsWith('http')) {
  //       return 'https://roobai.com/assets/images/banner/collage/new/${banner.image}';
  //     }
  //     return banner.image!;
  //   }
  //   if (banner.img_url?.isNotEmpty == true) return banner.img_url!;
  //   return null;
  // }
}
