import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

// void showProductPopup(BuildContext context, Product product, String storeName) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.white,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (context) => SmallProductPopup(product: product, storeName: storeName),
//   );
// }

class SmallProductPopup extends StatefulWidget {
  final Product product;

  const SmallProductPopup({super.key, required this.product});

  @override
  State<SmallProductPopup> createState() => _SmallProductPopupState();
}

class _SmallProductPopupState extends State<SmallProductPopup> {
  bool _isLoading = false;

  Future<void> _launchProductUrl() async {
    final url = widget.product.productPageUrl ?? widget.product.productUrl;
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product URL not available")),
      );
      return;
    }

    final uri = Uri.parse(url.startsWith("http") ? url : "https://$url");

    setState(() => _isLoading = true);
    HapticFeedback.mediumImpact();

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to open product URL")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error launching URL: $e")));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showShareDialog() {
    final shareUrl = widget.product.shareUrl ?? '';
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final description =
        widget.product.productDescription ?? "No description available";
    final mrp = double.tryParse(widget.product.productSalePrice ?? '') ?? 0;
    final offerPrice =
        double.tryParse(widget.product.productOfferPrice ?? '') ?? 0;
    final discount = (mrp > 0) ? (((mrp - offerPrice) / mrp) * 100).round() : 0;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top action row with share, title, close
            Row(
              children: [
                IconButton(
                  onPressed: _showShareDialog,
                  icon: const Icon(Icons.share),
                ),
                const Spacer(),
                if (discount >= 80)
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 4,
                    ), // spacing below badge
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'G.O.A.T',
                      style: AppConstants.headerwhite
                    ),
                  ),

                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Product Image
            if (widget.product.productImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.product.productImage!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, size: 40),
                  ),
                ),
              ),

            const SizedBox(height: 12),

            if (widget.product.productName != null)
              Text(
                widget.product.productName!,
                style:AppConstants.headerblack,
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 12),

            // Scrollable Description
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: AppConstants.headerblack,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buy Now Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _launchProductUrl,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
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
                            widget.product.storeName!,
                            style: AppConstants.textblack
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
}
