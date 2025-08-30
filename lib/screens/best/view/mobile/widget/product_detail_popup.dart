import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class SmallProductPopup extends StatefulWidget {
  final Product product;

  const SmallProductPopup({super.key, required this.product});

  @override
  State<SmallProductPopup> createState() => _SmallProductPopupState();
}

class _SmallProductPopupState extends State<SmallProductPopup>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Create animations
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start animations
    _slideController.forward();
    _scaleController.forward();
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _launchProductUrl() async {
    final url = widget.product.productPageUrl ?? widget.product.productUrl;
    if (url == null || url.isEmpty) {
      _showStylishSnackBar("Product URL not available", isError: true);
      return;
    }

    final uri = Uri.parse(url.startsWith("http") ? url : "https://$url");

    setState(() => _isLoading = true);
    HapticFeedback.mediumImpact();

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);
      if (!launched) {
        _showStylishSnackBar("Failed to open product URL", isError: true);
      }
    } catch (e) {
      _showStylishSnackBar("Error launching URL: $e", isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showStylishSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showShareDialog() {
    final shareUrl = widget.product.shareUrl ?? '';
    if (shareUrl.isEmpty) return;

    HapticFeedback.lightImpact();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.share,
                    color: Colors.deepPurple,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Share Product',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose how you\'d like to share this amazing product',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildDialogButton(
                        icon: Icons.content_copy,
                        label: 'Copy Link',
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: shareUrl));
                          Navigator.of(context).pop();
                          _showStylishSnackBar('Link copied to clipboard!');
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDialogButton(
                        icon: Icons.share,
                        label: 'Share',
                        isPrimary: true,
                        onPressed: () {
                          Share.share(shareUrl);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return Material(
      elevation: isPrimary ? 2 : 0,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isPrimary ? Colors.deepPurple : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: isPrimary ? null : Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : Colors.deepPurple,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final description =
        widget.product.productDescription ?? "No description available";
         String cleanDescription = description
                  .replaceAll(RegExp(r'I/flutter \(\s*\d+\):\s*│\s*🐛\s*'), '')
                  .replaceAll('Product Description:', '')
                  .replaceAll('🟡', '')
                  .trim();

              List<String> descriptionParts = description.split(
                RegExp(r'Disclaimer:|Note:|Disclosure:'),
              );
              String mainDescription = descriptionParts.isNotEmpty
                  ? descriptionParts[0].trim()
                  : '';

              if (mainDescription.isEmpty) {
                mainDescription =
                    'High-quality product with excellent features and performance.';
              }

            
    final mrp = double.tryParse(widget.product.productSalePrice ?? '') ?? 0;
    final offerPrice =
        double.tryParse(widget.product.productOfferPrice ?? '') ?? 0;
    final discount = (mrp > 0) ? (((mrp - offerPrice) / mrp) * 100).round() : 0;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Row(
                children: [
                  _buildActionButton(
                    icon: Icons.share_rounded,
                    onPressed: _showShareDialog,
                  ),
                  const Spacer(),
                  if (discount >= 80)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.deepPurple, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                       
                        ],
                      ),
                    ),
                  const Spacer(),
                  _buildActionButton(
                    icon: Icons.close_rounded,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (widget.product.productImage != null)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey.shade50, Colors.white],
                        ),
                      ),
                      child: Image.network(
                        widget.product.productImage!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Image not available',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              if (widget.product.productName != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.product.productName!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              const SizedBox(height: 16),

              if (mrp > 0 || offerPrice > 0)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (offerPrice > 0) ...[
                          Text(
                            '₹${offerPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (mrp > 0 && mrp != offerPrice) ...[
                          Text(
                            '₹${mrp.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (discount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade500,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$discount% OFF',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 120),
                child: Scrollbar(
                  thumbVisibility: true, // always show scrollbar thumb
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    primary: true,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        cleanDescription ?? "No description available.",
                        style: AppConstants.headerblack,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _launchProductUrl,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Get Deal',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, color: Colors.grey.shade700, size: 22),
        ),
      ),
    );
  }
}
