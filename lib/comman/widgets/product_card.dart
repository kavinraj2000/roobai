import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/comman/widgets/itext.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product/view/widget/Product_datetime.dart';
import 'package:roobai/screens/product/view/widget/product_detail_popup.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  // final List<HomeModel>? homemodel;
  final VoidCallback? onTap;
  final bool showStoreName;
  final bool showDiscountBadge;
  final bool showDateTime;
  final bool enableBottomSheet;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    // this.homemodel,
    this.showStoreName = true,
    this.showDiscountBadge = true,
    this.showDateTime = true,
    this.enableBottomSheet = true,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final Logger log = Logger();

  @override
  Widget build(BuildContext context) {
    // log.d('homemodel::data:ProductCard:${widget.homemodel!.first.data!.first.itext}');
    // final itext=widget.homemodel!.first.data!.first.itext;
    final offerPrice =
        double.tryParse(widget.product.productOfferPrice?.toString() ?? '0') ?? 0;
    final salePrice =
        double.tryParse(widget.product.productSalePrice?.toString() ?? '0') ?? 0;

    final discountPercentage = salePrice > 0
        ? ((salePrice - offerPrice) / salePrice * 100).round()
        : 0;

    return InkWell(
      onTap: widget.onTap ??
          () {
            if (widget.enableBottomSheet) {
              log.d('BottomSheet opened with product ::${widget.product.toMap()}');
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
      builder: (_) => SmallProductPopup(product: product),
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

            // Expired or GOAT Badge
            if (isExpired || (!isExpired && discountPercentage >= 80))
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isExpired ? Colors.red : Colors.deepPurple,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      isExpired ? 'Expired' : 'G.O.A.T',
                      style: AppConstants.headerwhite,
                    ),
                  ),
                ),
              ),

            if (widget.showStoreName &&
                widget.product.storeName != null &&
                widget.product.storeName!.isNotEmpty)
             Positioned(
      bottom: 0, // distance from bottom
      left: 4,
      right: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
          GestureDetector(
            onTap: () => _showSmartProductDialog(context),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.info,
                size: 16,
                color: Color.fromARGB(255, 207, 206, 206),
              ),
            ),
          ),
        ],
      ),
    ),
          ],
        ),
      ),
    );
  }




   void _showSmartProductDialog(BuildContext context,) {
    showDialog(
      context: context,
      builder: (context) {
        return SmartProductInfoDialog(
          title: "disclaimer",
          description: 'apiText',
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
          if (widget.product.productName != null)
            Text(widget.product.productName!,
                maxLines: 2, overflow: TextOverflow.ellipsis, style: AppConstants.headerblack),
          const SizedBox(height: 4),
          Row(
            children: [
              Text("₹${offerPrice.toStringAsFixed(0)}", style: AppConstants.headerblack),
              const SizedBox(width: 10),
              if (salePrice > 0)
                Text("₹${salePrice.toStringAsFixed(0)}", style: AppConstants.offer),
              const Spacer(),
              if (widget.showDiscountBadge && discountPercentage > 0)
                Row(
                  children: [
                    Text("$discountPercentage%", style: AppConstants.textblack),
                    const SizedBox(width: 2),
                  ],
                ),
            ],
          ),
          if (widget.showDateTime && widget.product.dateTime != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Datetimewidget(dateTime: widget.product.dateTime),
            ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    if (widget.product.productImage != null &&
        widget.product.productImage!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          widget.product.productImage!,
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
    }
    return _buildImagePlaceholder();
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
