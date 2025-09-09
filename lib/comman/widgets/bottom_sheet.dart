import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';

class ProductDetailsBottomSheet extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsBottomSheet({super.key, required this.product});

  static void show(BuildContext context, ProductModel product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => ProductDetailsBottomSheet(product: product),
    );
  }

  @override
  State<ProductDetailsBottomSheet> createState() =>
      _ProductDetailsBottomSheetState();
}

class _ProductDetailsBottomSheetState extends State<ProductDetailsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final mrp = double.tryParse(widget.product.productSalePrice ?? '') ?? 0;
    final offer = double.tryParse(widget.product.productOfferPrice ?? '') ?? 0;
    final discount = mrp > 0 ? (((mrp - offer) / mrp) * 100).round() : 0;
    final isExpired = widget.product.stockStatus?.toString() == '1';
    final savings = mrp - offer;

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
              spreadRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHandleBar(),
                const SizedBox(height: 24),
                _buildProductImage(), // now just static image
                const SizedBox(height: 24),
                _buildProductInfo(),
                const SizedBox(height: 16),
                if (widget.product.storeName != null &&
                    widget.product.storeName!.isNotEmpty)
                  _buildStoreInfo(),
                const SizedBox(height: 20),
                _buildPriceSection(mrp, offer, discount, savings),
                const SizedBox(height: 24),
                if (isExpired || discount >= 80)
                  _buildStatusBadge(isExpired, discount),
                const SizedBox(height: 32),
                _buildActionButtons(isExpired),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandleBar() {
    return Column(
      children: [
         Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){
                  context.pop();
                }, icon: Icon(Icons.close_rounded))
              ],
            ),
        Center(
          child: Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade300, Colors.grey.shade400],
              ),
              borderRadius: BorderRadius.circular(3),
        
            ),
         
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Center(
        child: Container(
          height: 220,
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 20,
                offset: const Offset(-8, -8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:
                widget.product.productImage != null &&
                    widget.product.productImage!.isNotEmpty
                ? Hero(
                    tag: 'product_${widget.product.pid}',
                    child: Image.network(
                      widget.product.productImage!,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                          ),
                        );
                      },
                    ),
                  )
                : _buildPlaceholder(),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade100, Colors.grey.shade200],
        ),
      ),
      child: const Center(
        child: Icon(Icons.image_outlined, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.productName ?? 'Product',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.blue.shade100],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.shade200, width: 0.5),
          ),
          child: Text(
            widget.product.productDescription ?? '',
            style:AppConstants.textblack
          ),
        ),
      ],
    );
  }

  Widget _buildStoreInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF5DC02).withOpacity(0.9),
            const Color(0xFFF5DC02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF5DC02).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.store, color: Colors.black87, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available at',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.product.storeName!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(
    double mrp,
    double offer,
    int discount,
    double savings,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${offer.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(width: 12),
              if (mrp > 0)
                Text(
                  '₹${mrp.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2,
                  ),
                ),
              const Spacer(),
              if (discount > 0) _buildDiscountBadge(discount),
            ],
          ),
          if (savings > 0) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.savings, color: Colors.green.shade600, size: 20),
                const SizedBox(width: 8),
                Text(
                  'You save ₹${savings.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDiscountBadge(int discount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getThunderColor(discount),
            _getThunderColor(discount).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _getThunderColor(discount).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$discount% OFF',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.flash_on, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isExpired, int discount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isExpired
              ? [Colors.red.shade50, Colors.red.shade100]
              : [Colors.purple.shade50, Colors.purple.shade100],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpired ? Colors.red.shade200 : Colors.purple.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isExpired ? Colors.red.shade100 : Colors.purple.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isExpired ? Icons.warning_amber : Icons.star,
              color: isExpired ? Colors.red.shade600 : Colors.purple.shade600,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isExpired ? 'Deal Expired' : 'G.O.A.T Deal!',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isExpired
                        ? Colors.red.shade700
                        : Colors.purple.shade700,
                  ),
                ),
                Text(
                  isExpired
                      ? 'This offer is no longer available'
                      : 'Greatest Of All Time deal - Don\'t miss it!',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isExpired
                        ? Colors.red.shade600
                        : Colors.purple.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isExpired) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildWishlistButton()),
            const SizedBox(width: 16),
            Expanded(flex: 2, child: _buildViewProductButton(isExpired)),
          ],
        ),
        const SizedBox(height: 12),
        _buildShareButton(),
      ],
    );
  }

  Widget _buildWishlistButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _isFavorite = !_isFavorite;
          });
          // Add haptic feedback
          // HapticFeedback.lightImpact();
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(
            color: _isFavorite ? Colors.red.shade300 : Colors.grey.shade300,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: _isFavorite
              ? Colors.red.shade50
              : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 20,
                color: _isFavorite ? Colors.red : Colors.grey.shade600,
                key: ValueKey(_isFavorite),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _isFavorite ? 'Added to Wishlist' : 'Add to Wishlist',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _isFavorite ? Colors.red : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewProductButton(bool isExpired) {
    return ElevatedButton(
      onPressed: isExpired
          ? null
          : () {
              Navigator.pop(context);
              context.read<HomepageBloc>().add(
                NavigateToProductEvent(widget.product.productUrl),
              );
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: isExpired
            ? Colors.grey.shade400
            : Colors.blue.shade600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: isExpired ? 0 : 8,
        shadowColor: Colors.blue.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isExpired ? Icons.block : Icons.shopping_bag_outlined, size: 20),
          const SizedBox(width: 8),
          Text(
            isExpired ? 'Deal Expired' : 'View Product',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          // Implement share functionality
          Navigator.pop(context);
          // Share.share('Check out this amazing deal: ${widget.product.productName}');
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.share_outlined, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              'Share this deal',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getThunderColor(int discount) {
    if (discount >= 80) {
      return Colors.green;
    } else if (discount >= 50) {
      return Colors.blue;
    } else if (discount >= 25) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
