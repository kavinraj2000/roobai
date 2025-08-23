import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:google_fonts/google_fonts.dart';

class PriceFormatter {
  static String formatPrice(dynamic price) {
    if (price == null) return '0';
    return price.toString();
  }
}

// Dummy ProductDatetime widget to replace your external one
class ProductDatetime extends StatelessWidget {
  final DateTime? dateTime;

  const ProductDatetime({Key? key, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dateTime == null) return const SizedBox.shrink();

    // Format date/time however you want
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 6),
          Text(
            "${dateTime!.day}/${dateTime!.month}/${dateTime!.year} ${dateTime!.hour}:${dateTime!.minute.toString().padLeft(2, '0')}",
            style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
=======
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/features/product/shared/widget/appbarwidget.dart';
import 'package:roobai/features/product/shared/widget/loader.dart';
import 'package:roobai/screens/product_detail/bloc/product_detail_bloc.dart';
import 'package:roobai/screens/product_detail/view/mobile/widget/Product_content.dart';
import 'package:share_plus/share_plus.dart';
>>>>>>> 2e0ab4f666631e29bad84078616e96db3915f10b

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ProductDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // Hardcoded product data
    final productName = "Classic Leather Shoes";
    final productImage = "https://via.placeholder.com/400";
    final productOfferPrice = 89.99;
    final productSalePrice = 120.00;
    final storeName = "Fashion Store";
    final productDescription =
        "These classic leather shoes are perfect for both formal and casual occasions. Made from high-quality leather, they offer comfort and durability with a timeless style.";
    final dateTime = DateTime(2024, 8, 22, 15, 30);
    final rating = 4.7;
    final reviewsCount = 128;
    final List<String> features = [
      "Genuine Leather",
      "Comfortable Insole",
      "Durable Sole",
      "Water Resistant",
      "Breathable Material",
    ];

    final discount = productSalePrice > 0
        ? ((productSalePrice - productOfferPrice) / productSalePrice * 100)
              .round()
        : 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.favorite_border,
                color: Colors.deepPurple,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image with gradient overlay
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.network(
                      productImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "$discount% OFF",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
=======
    final salePrice = double.tryParse(data['product_sale_price']) ?? 0.0;
    final offerPrice = double.tryParse(data['product_offer_price']) ?? 0.0;
    final discountPercentage = salePrice > 0
        ? ((salePrice - offerPrice) / salePrice * 100).round()
        : 0;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state.status == ProductDetailStatus.loading) {
            return const Center(child: LoadingPage());
          }

          if (state.status == ProductDetailStatus.loaded) {
            return Column(
              children: [
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
                              color: Colors.white.withOpacity(0.2),
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


// Inside your widget build method:

GestureDetector(
  onTap: () async {
    final shareUrl = data['share_url'] ?? '';

    if (shareUrl.isEmpty) {
      // Handle empty URL case if needed
      return;
    }

    // Show dialog with options to share or copy
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Share Product'),
          content: Text('Would you like to share the product or copy the link?'),
          actions: [
            TextButton(
              onPressed: () {
                // Copy to clipboard
                Clipboard.setData(ClipboardData(text: shareUrl));
                Navigator.of(context).pop();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link copied to clipboard!')),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
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
      color: Colors.white.withOpacity(0.2),
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

                // Body Scrollable Content
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.network(
                                      data['product_image'],
                                      fit: BoxFit.cover,
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
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // Favorite Icon
                                Positioned(
                                  top: 20,
                                  right: 20,
                                  child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                                    builder: (context, state) {
                                      return GestureDetector(
                                        onTap: () {
                                          // HapticFeedback.lightImpact();
                                          // context.read<ProductDetailBloc>().add(ToggleFavoriteEvent());
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: state.isFavorite
                                                ? Colors.red.withOpacity(0.9)
                                                : Colors.black.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                color: state.isFavorite
                                                    ? Colors.red.withOpacity(0.4)
                                                    : Colors.black.withOpacity(0.2),
                                                offset: const Offset(0, 4),
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            state.isFavorite ? Icons.favorite : Icons.favorite_border,
                                            color: Colors.white,
                                            size: 26,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // Discount Badge
                                Positioned(
                                  top: 20,
                                  left: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF4CAF50).withOpacity(0.4),
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
>>>>>>> 2e0ab4f666631e29bad84078616e96db3915f10b
                    ),
                  ),
                ),
              ],
            );
          }

<<<<<<< HEAD
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          productName,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              " ($reviewsCount)",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.store,
                          size: 18,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        storeName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.verified, size: 16, color: Colors.blue),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Pricing Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "₹${PriceFormatter.formatPrice(productOfferPrice)}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            if (productSalePrice > 0)
                              Text(
                                "₹${PriceFormatter.formatPrice(productSalePrice)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        // const ProductDatetime(dateTime: dateTime),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Features
                  Text(
                    "Key Features",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: features.map((feature) {
                      return Chip(
                        backgroundColor: Colors.deepPurple.withOpacity(0.1),
                        label: Text(
                          feature,
                          style: const TextStyle(color: Colors.deepPurple),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    productDescription,
                    style: GoogleFonts.sora(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.deepPurple,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
=======
          return const Center(child: Text('No data available'));
        },
>>>>>>> 2e0ab4f666631e29bad84078616e96db3915f10b
      ),
    );
  }
}
