import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/widgets/loader.dart';
import 'package:roobai/screens/product_detail/bloc/product_detail_bloc.dart';
import 'package:roobai/screens/product_detail/view/mobile/widget/Product_content.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ProductDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final salePrice = double.tryParse(data['product_sale_price']) ?? 0.0;
    final offerPrice = double.tryParse(data['product_offer_price']) ?? 0.0;
    final discountPercentage = salePrice > 0
        ? ((salePrice - offerPrice) / salePrice * 100).round()
        : 0;

    return Scaffold(
      backgroundColor: Colors.grey[50],

      /// ✅ Removed `CustomAppBar()`, since you already built a custom header
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              final productUrl = data['product_url'] ?? '';
              final storeName = data['store_name'] ?? 'Buy Now';

              return SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: state.status == ProductDetailStatus.loading
                      ? null
                      : () async {
                          HapticFeedback.mediumImpact();

                          await launchUrl(
                            Uri.parse(productUrl),
                            mode: LaunchMode.inAppWebView,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shadowColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: state.status == ProductDetailStatus.loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              storeName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            },
          ),
        ),
      ),

      // ✅ Main product detail content
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state.status == ProductDetailStatus.loading) {
            return const Center(child: LoadingPage());
          }

          if (state.status == ProductDetailStatus.loaded) {
            return Column(
              children: [
                /// ✅ Custom Header
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            context.goNamed(RouteName.product);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Product Detail',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),

                        // ✅ Share icon
                        GestureDetector(
                          onTap: () async {
                            final shareUrl = data['share_url'] ?? '';

                            if (shareUrl.isEmpty) return;

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Share Product'),
                                  content: const Text(
                                    'Would you like to share the product or copy the link?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(text: shareUrl),
                                        );
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Link copied to clipboard!',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Copy Link'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Share.share(shareUrl);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Share'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.share_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ✅ Product image and discount badge
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 380,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF2A2A2A), Color(0xFF1A1A1A)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 8),
                                blurRadius: 24,
                                spreadRadius: -4,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.network(
                                    data['product_image'],
                                    fit: BoxFit.contain, // ✅ better fit
                                    width: double.infinity,
                                    height: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                  ),
                                ),

                                // Favorite button
                                Positioned(
                                  top: 20,
                                  right: 20,
                                  child:
                                      BlocBuilder<
                                        ProductDetailBloc,
                                        ProductDetailState
                                      >(
                                        builder: (context, state) {
                                          return GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<ProductDetailBloc>()
                                                  .add(ToggleFavoriteEvent());
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: state.isFavorite
                                                    ? Colors.red.withOpacity(
                                                        0.9,
                                                      )
                                                    : Colors.black.withOpacity(
                                                        0.3,
                                                      ),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: state.isFavorite
                                                        ? Colors.red
                                                              .withOpacity(0.4)
                                                        : Colors.black
                                                              .withOpacity(0.2),
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 8,
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                state.isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.white,
                                                size: 26,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                ),

                                // Discount Badge
                                if (discountPercentage > 0)
                                  Positioned(
                                    top: 20,
                                    left: 20,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF4CAF50),
                                            Color(0xFF45A049),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(
                                              0xFF4CAF50,
                                            ).withOpacity(0.4),
                                            offset: const Offset(0, 4),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        ' $discountPercentage% off',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        ProductContentWidget(data: data),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
