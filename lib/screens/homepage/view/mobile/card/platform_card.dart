import 'package:flutter/material.dart';
import 'package:roobai/comman/model/home_model.dart';

class PlatformCard extends StatelessWidget {
  final Data productData; // Change to Data instead of HomeModel
  final String? discount;

  const PlatformCard({super.key, required this.productData, this.discount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle navigation to product details
        print("Product tapped: ${productData.productName}");
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: Image.network(
                        _getImageUrl(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                      ),
                    ),
                    // Discount Badge
                    if (discount != null && discount!.isNotEmpty)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            discount!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Product Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Title
                    Text(
                      productData.productName ??
                          productData.bannerName ??
                          "No Title",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Store Name - Fixed the condition
                    if (productData.storeName != null &&
                        productData.storeName!.isNotEmpty)
                      Text(
                        productData.storeName!,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    // Price
                    Row(
                      children: [
                        if (productData.productOfferPrice != null &&
                            productData.productOfferPrice!.isNotEmpty)
                          Text(
                            '₹${productData.productOfferPrice}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),

                        if (productData.productSalePrice != null &&
                            productData.productSalePrice!.isNotEmpty &&
                            productData.productOfferPrice !=
                                productData.productSalePrice)
                          Expanded(
                            child: Text(
                              ' ₹${productData.productSalePrice}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getImageUrl() {
    if (productData.productImage != null &&
        productData.productImage!.isNotEmpty) {
      return productData.productImage!;
    }
    if (productData.image != null && productData.image!.isNotEmpty) {
      return productData.image!;
    }
    if (productData.img_url != null && productData.img_url!.isNotEmpty) {
      return productData.img_url!;
    }
    if (productData.image1 != null && productData.image1!.isNotEmpty) {
      return productData.image1!;
    }
    return "https://via.placeholder.com/150x150?text=No+Image";
  }
}
