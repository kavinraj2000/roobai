import 'package:flutter/material.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturedBannerWidget extends StatelessWidget {
  final List<HomeModel> banners;

  const FeaturedBannerWidget({super.key, required this.banners});

  Future<void> _launchUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $e')),
      );
    }
  }

  List<BannerItem> _getBannerItems() {
    List<BannerItem> bannerItems = [];
    for (var banner in banners) {
      if (banner.data != null) {
        bannerItems.addAll(
          banner.data!
              .where((item) => item.image1 != null && item.image1!.isNotEmpty)
              .map(
                (item) => BannerItem(
                  imageUrl: item.image1!,
                  url: item.url ?? item.filler1,
                  bannername: item.bannerName,
                ),
              ),
        );
      }
    }
    return bannerItems;
  }

  @override
  Widget build(BuildContext context) {
    final bannerItems = _getBannerItems();

    if (bannerItems.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: bannerItems.length,
        itemBuilder: (context, index) {
          final banner = bannerItems[index]; // Current banner item

          return GestureDetector(
            onTap: () {
              if (banner.url != null && banner.url!.isNotEmpty) {
                _launchUrl(context, banner.url!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No URL available')),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                banner.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class BannerItem {
  final String imageUrl;
  final String? url;
  final String? bannername;

  BannerItem({required this.imageUrl, this.url, this.bannername});
}
