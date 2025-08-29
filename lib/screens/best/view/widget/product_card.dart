import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product/view/widget/Product_datetime.dart';
import 'package:roobai/screens/product/view/widget/product_detail_popup.dart';

class BestProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;
  final bool showStoreName;
  final bool showDiscountBadge;
  final bool showDateTime;
  final bool enableBottomSheet;

  const BestProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.showStoreName = true,
    this.showDiscountBadge = true,
    this.showDateTime = true,
    this.enableBottomSheet = true,
  });

  @override
  State<BestProductCard> createState() => _BestProductCardState();
}

class _BestProductCardState extends State<BestProductCard> {
  @override
  Widget build(BuildContext context) {
    final log = Logger();

    final offerPrice =
        double.tryParse(widget.product.productOfferPrice?.toString() ?? '0') ??
            0;
    final salePrice =
        double.tryParse(widget.product.productSalePrice?.toString() ?? '0') ??
            0;

    final discountPercentage = salePrice > 0
        ? ((salePrice - offerPrice) / salePrice * 100).round()
        : 0;

    return InkWell(
      onTap: widget.onTap ??
          () {
            if (widget.enableBottomSheet) {
              log.d(
                'BottomSheet opened with product ::${widget.product.toMap()}',
              );
              _showProductBottomSheet(context, widget.product);
            }
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
            _buildContentSection(offerPrice, salePrice, discountPercentage),
          ],
        ),
      ),
    );
  }

  void _showProductBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SmallProductPopup(product: product);
      },
    );
  }

  Widget _buildImageSection(int discountPercentage) {
    final bool isExpired = widget.product.stockStatus?.toString() == '1';

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

            if (isExpired)
                   Center(
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'EXPIRED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

            // GOAT badge if not expired and discount >= 80
            if (!isExpired &&
                widget.showDiscountBadge &&
                discountPercentage >= 80)
              Positioned(
                top: -2,
                bottom: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'G.O.A.T',
                      style: AppConstants.headerwhite,
                    ),
                  ),
                ),
              ),

            // Store Name
            if (widget.showStoreName &&
                widget.product.storeName != null &&
                widget.product.storeName!.isNotEmpty)
              Positioned(
                bottom: 4,
                left: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5DC02),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.product.storeName!,
                    style: GoogleFonts.sora(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

            // Info Icon
            Positioned(
              bottom: 2,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  _showDescriptionDialog(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.info,
                    size: 16,
                    color: Color.fromARGB(255, 207, 206, 206),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 16,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info, color: Colors.blue, size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.product.productName ?? '',
                          style: AppConstants.headerblack,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.product.productDescription ??
                            "No description available.",
                        style: AppConstants.headerblack,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text("Close"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContentSection(
      double offerPrice, double salePrice, int discountPercentage) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.product.productName != null &&
              widget.product.productName!.isNotEmpty)
            Text(
              widget.product.productName!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.headerblack,
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "₹${offerPrice.toStringAsFixed(0)}",
                style: AppConstants.headerblack,
              ),
              const SizedBox(width: 10),
              if (salePrice > 0)
                Text(
                  "₹${salePrice.toStringAsFixed(0)}",
                  style: AppConstants.offer,
                ),
              const SizedBox(width: 60),
              if (widget.showDiscountBadge && discountPercentage > 0)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _getDiscountBadgeColor(discountPercentage),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "$discountPercentage",
                        style: AppConstants.textwhite,
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        LucideIcons.trendingDown,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (widget.showDateTime && widget.product.dateTime != null) ...[
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Datetimewidget(dateTime: widget.product.dateTime)],
            ),
          ],
        ],
      ),
    );
  }

  Color _getDiscountBadgeColor(int discount) {
    if (discount < 25) {
      return Colors.red;
    } else if (discount >= 50 && discount <= 70) {
      return Colors.blue;
    } else {
      return Colors.green.shade600;
    }
  }

  Widget _buildProductImage() {
    if (widget.product.productImage != null &&
        widget.product.productImage!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          widget.product.productImage!,
          fit: BoxFit.contain,
          // width: double.infinity,
          // height: double.infinity,
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
            Text("No Image", style: AppConstants.headerblack),
          ],
        ),
      ),
    );
  }
}
