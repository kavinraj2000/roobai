import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:roobai/screens/product_detail/bloc/product_detail_bloc.dart';
import 'package:roobai/screens/product_detail/view/mobile/widget/Product_priceformattor.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductContentWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProductContentWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final log = Logger();
    
    // Extract data safely with defaults
    final productName = data['product_name'] ?? 'Product Name';
    final salePrice = double.tryParse(data['product_sale_price']) ?? 0.0;
    final offerPrice = double.tryParse(data['product_offer_price']) ?? 0.0;
    final storeName = data['store_name'] ?? 'Store';
    final productDescription = data['product_description'];
    final storeImage = data['store_image'] ;
    final Producturl=data['product_url'];
    final stockstatus=data['stock_status'];
    final updateddate=data['date_time'];
    final comment=data['comment_count'];
    final like=data['like_status'];
    final coupen=data['coupen'];
    final roopaipageurl=data['share_url'];
    final storeurl=data['store_url'];
    final savings = salePrice - offerPrice;

    if (data.containsKey('product_description')) {
  String rawDescription = data['product_description'] ?? '';

  String cleanedDescription = rawDescription
      .replaceAll(RegExp(r'I/flutter \(\s*\d+\):\s*│\s*🐛\s*'), '')
      .replaceAll('Product Description:', '')
      .replaceAll('Disclaimer:', '')
      .replaceAll('Note:', '')
      .replaceAll('Disclosure:', '')
      .replaceAll('🟡', '')
      .replaceAll('│ 🐛', '')
      .replaceAll('\n', ' ')
      .replaceAll(RegExp(r'\s+'), ' ') // Collapse multiple spaces
      .trim();

  // Set back cleaned version into data
  data['product_description'] = cleanedDescription.isNotEmpty
      ? cleanedDescription
      : 'High-quality product with excellent features and performance.';
}
    
    log.d('ProductContentWidget::data::::${data['product_description']}');
  
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4CAF50).withOpacity(0.1),
                  const Color(0xFF4CAF50).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4CAF50).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.trending_down,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    PriceFormatter.formatPrice(salePrice),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey[400],
                      decorationThickness: 2,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    PriceFormatter.formatPrice(offerPrice),
                    style: const TextStyle(
                      color: Color(0xFF7B3F9E),
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  const Spacer(),
                  if (savings > 0)
                    Container(
                      padding: const EdgeInsets.all(4
                        
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Save ${PriceFormatter.formatPrice(savings)}',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            productName,
            style: const TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              height: 1.3,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

  Row(
  children: [
    // Like icon + count
    Row(
      children: [
        Icon(
          Icons.thumb_up_alt_outlined,  // Like icon
          color: Colors.redAccent,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          '${data['like_status']}',  // Use your like count variable here
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),

    const SizedBox(width: 16),

    // Comment icon + count
    Row(
      children: [
        Icon(
          Icons.comment_outlined,  // Comment icon
          color: Colors.blueAccent,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          '${data['comment_count']}',  // Use your like count variable here
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
           const SizedBox(width: 4),
        Text(
          '${data['coupon']}',  // Use your like count variable here
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  ],
),


          const SizedBox(height: 20),

          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              String cleanDescription = productDescription
                  .replaceAll(RegExp(r'I/flutter \(\s*\d+\):\s*│\s*🐛\s*'), '')
                  .replaceAll('Product Description:', '')
                  .replaceAll('🟡', '')
                  .trim();
              
              List<String> descriptionParts = productDescription.split(RegExp(r'Disclaimer:|Note:|Disclosure:'));
              String mainDescription = descriptionParts.isNotEmpty 
                  ? descriptionParts[0].trim() 
                  : '';
              
              if (mainDescription.isEmpty) {
                mainDescription = 'High-quality product with excellent features and performance.';
              }
              
              String displayDescription = state.showFullDescription
                  ? mainDescription
                  : (mainDescription.length > 100 
                      ? '${mainDescription.substring(0, 100)}...' 
                      : mainDescription);
             return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Product Details',
      style: GoogleFonts.poppins(  // 👈 title font
        color: const Color(0xFF2D2D2D),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    const SizedBox(height: 12),
    Text(
      cleanDescription,
      style: GoogleFonts.roboto(  // 👈 body font
        color: const Color(0xFF555555),
        fontSize: 15,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    ),
    if (productDescription.length > 100) ...[
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () => context.read<ProductDetailBloc>().add(
              ToggleDescriptionEvent(),
            ),
        child: Text(
          state.showFullDescription ? 'Show less' : 'Read more',
          style: GoogleFonts.poppins(  // 👈 link font
            color: const Color(0xFF7B3F9E),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  ],
);

            },
          ),

          const SizedBox(height: 24),

          // Store section - Using dynamic store data
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF7B3F9E).withOpacity(0.1),
                  const Color(0xFF7B3F9E).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF7B3F9E).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Store image
                if (storeImage.isNotEmpty)
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(storeImage),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                if (storeImage.isNotEmpty) const SizedBox(width: 12),
                
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$storeName ',
                          style: TextStyle(
                            color: storeName.toLowerCase() == 'amazon' 
                                ? const Color(0xFFE53E3E)
                                : const Color(0xFF7B3F9E),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: storeName.toLowerCase() == 'amazon'
                              ? 'Prime eligible with free delivery on orders over ₹499. Fast shipping and reliable service.'
                              : 'Trusted seller with quality products and customer support.',
                          style: const TextStyle(
                            color: Color(0xFF7B3F9E),
                            fontSize: 15,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Add to Cart Button
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              return Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF8E4EC6), Color(0xFF7B3F9E)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7B3F9E).withOpacity(0.4),
                      offset: const Offset(0, 8),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: state.status == ProductDetailStatus.loading
                      ? null
                      : () async {
                        
                          HapticFeedback.mediumImpact();
                          
                         
                        await launchUrl(
  Uri.parse(Producturl),
  mode: LaunchMode.inAppWebView,
);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
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
                      :  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Text(
                              '$storeName',
                              style: TextStyle(
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
        ],
      ),
    );
  }
}