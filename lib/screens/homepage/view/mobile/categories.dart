import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({super.key, required this.category, this.onTap});

  static const List<LinearGradient> cardGradients = [
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFF6B9D), Color(0xFFFF8BA7)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF8BC34A), Color(0xFF689F38)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFEB3B), Color(0xFFFBC02D)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFF9800), Color(0xFFE65100)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final String? imageUrl =
        (category.categoryImage != null && category.categoryImage!.isNotEmpty)
            ? 'https://roobai.com/assets/img/sale_cat_img/${category.categoryImage}'
            : null;

    Logger().d('Image URL: $imageUrl');

    final gradientIndex =
        (category.category?.hashCode ?? 0).abs() % cardGradients.length;
    final cardGradient = cardGradients[gradientIndex];

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100, 
        height: 120, 
        child: Container(
          decoration: BoxDecoration(
            gradient: cardGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Flexible(
                  child: Text(
                    category.category ?? 'Unnamed',
                    style: AppConstants.headerwhite.copyWith(fontSize: 12),
                    maxLines: 2,
                  ),
                ),

                // const Spacer(),

                SizedBox(
                  width: 60,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.contain,
                                placeholder: (context, url) =>
                                    _loadingPlaceholder(),
                                errorWidget: (context, url, error) =>
                                    _placeholder(),
                              )
                            : _placeholder(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: Center(
        child: Icon(Icons.category_outlined, size: 22, color: Colors.grey[600]),
      ),
    );
  }

  Widget _loadingPlaceholder() {
    return Container(
      color: Colors.white.withOpacity(0.8),
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}
