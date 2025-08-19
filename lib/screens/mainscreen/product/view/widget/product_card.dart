import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roobai/screens/mainscreen/product/model/products.dart';
import 'package:roobai/screens/mainscreen/product/view/widget/platform_utils.dart';
import 'package:roobai/screens/mainscreen/product/view/widget/product_priceformattor.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  const ProductCard({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final dealType = product.dealType?.toLowerCase() ?? 'amazon';
    final colors = PlatformUtils.platformColors[dealType] ?? PlatformUtils.platformColors['amazon']!;
    final platformIcon = PlatformUtils.platformIcons[dealType] ?? PlatformUtils.platformIcons['amazon']!;

    // Calculate discount percentage
    final offerPrice = double.tryParse(product.productOfferPrice?.toString() ?? '0') ?? 0;
    final salePrice = double.tryParse(product.productSalePrice?.toString() ?? '0') ?? 0;
    final discountPercentage = salePrice > 0 ? ((salePrice - offerPrice) / salePrice * 100).round() : 0;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.easeOutBack,
      child: GestureDetector(
        onTap: () {
          // Add haptic feedback
          HapticFeedback.lightImpact();
          // Navigate to product details
          // context.push('/product-details', extra: product);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 12,
                offset: const Offset(0, 6),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey.shade100, Colors.grey.shade200],
                        ),
                      ),
                      child: _buildProductImage(),
                    ),
                  ),
                  // Platform Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: colors),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: colors[0].withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            platformIcon,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            dealType.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Discount Badge
                  if (discountPercentage > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          "${discountPercentage}% OFF",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // Product Details Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        product.productName ?? "Product Name Not Available",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Offer Price
                          Row(
                            children: [
                              const Icon(
                                Icons.local_offer,
                                size: 14,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "₹${PriceFormatter.formatPrice(product.productOfferPrice)}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (product.productSalePrice != null &&
                              product.productSalePrice != product.productOfferPrice)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Row(
                                children: [
                                  const SizedBox(width: 18), // Align with price above
                                  Text(
                                    "₹${PriceFormatter.formatPrice(product.productSalePrice)}",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      decorationColor: Colors.red.shade400,
                                      decorationThickness: 2,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  if (discountPercentage > 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        "Save ${discountPercentage}%",
                                        style: TextStyle(
                                          color: Colors.red.shade700,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
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
      ),
    );
  }

  Widget _buildProductImage() {
    if (product.productImage != null) {
      return Image.network(
        product.productImage!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        },
        errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
      );
    } else {
      return _buildImagePlaceholder();
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            size: 40,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 4),
          Text(
            product.productImage == null ? "No image" : "Image not available",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}