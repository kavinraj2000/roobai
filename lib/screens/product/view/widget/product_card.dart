import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product/view/widget/Product_datetime.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final offerPrice =
        double.tryParse(product.productOfferPrice?.toString() ?? '0') ?? 0;
    final salePrice =
        double.tryParse(product.productSalePrice?.toString() ?? '0') ?? 0;
    final discountPercentage = salePrice > 0
        ? ((salePrice - offerPrice) / salePrice * 100).round()
        : 0;

    return InkWell(
      onTap: () {
        Logger().d('BottomSheet opened with product ::${product.toMap()}');
        _showProductBottomSheet(context, product);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(discountPercentage),
            _buildContentSection(offerPrice, salePrice),
            if (product.storeName != null && product.storeName!.isNotEmpty)
              _buildStoreNameSection(product.storeName!),
          ],
        ),
      ),
    );
  }

  /// ✅ Function to show BottomSheet
  void _showProductBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return ProductDetailSheet(product: product);
      },
    );
  }

  Widget _buildImageSection(int discountPercentage) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Stack(
          children: [
            Center(child: _buildProductImage()),

            // Discount Badge
            if (discountPercentage > 0)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$discountPercentage% OFF",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),

            // Favorite Button
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => Logger().d('onpressed ::like button'),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.red.shade400,
                    size: 14,
                  ),
                ),
              ),
            ),

            // ✅ GOAT Badge (only if discount ≥ 80%)
            if (discountPercentage >= 80)
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'GOAT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(double offerPrice, double salePrice) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (product.productName != null && product.productName!.isNotEmpty)
            Text(
              product.productName!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.sora(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "₹${product.productOfferPrice}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (salePrice > 0)
                Flexible(
                  child: Text(
                    "₹${product.productSalePrice}",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 9,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey.shade500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          if (product.dateTime != null) ...[
            const SizedBox(height: 4),
            Datetimewidget(dateTime: product.dateTime),
          ],
        ],
      ),
    );
  }

  Widget _buildStoreNameSection(String storeName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 245, 220, 2),
        border: Border(top: BorderSide(color: Colors.orange, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.store_outlined, size: 12, color: Colors.black),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              storeName,
              style: GoogleFonts.sora(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    if (product.productImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          product.productImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                  strokeWidth: 2,
                  color: Colors.blue.shade300,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return _buildImagePlaceholder();
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, size: 28, color: Colors.grey.shade400),
            const SizedBox(height: 2),
            Text(
              "No Image",
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Bottom Sheet Widget
class ProductDetailSheet extends StatelessWidget {
  final Product product;
  const ProductDetailSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Product Image
            if (product.productImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.productImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 12),

            // Product Name
            Text(
              product.productName ?? "Unnamed Product",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            // Price
            Text(
              "₹${product.productOfferPrice}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),

            if (product.productSalePrice != null)
              Text(
                "₹${product.productSalePrice}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),

            const SizedBox(height: 12),

            // Store
            if (product.storeName != null)
              Row(
                children: [
                  const Icon(Icons.store, size: 16),
                  const SizedBox(width: 6),
                  Text(product.storeName!),
                ],
              ),

            const SizedBox(height: 16),

            // Close button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
