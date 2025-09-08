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
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: cardGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.category ?? 'Unnamed',
                style: AppConstants.headerwhite,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),

              // Fixed size image/placeholder area
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: Colors.white.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => _loadingPlaceholder(),
                          errorWidget: (context, url, error) => _placeholder(),
                        )
                      : _placeholder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: Center(
        child: Icon(Icons.category_outlined, size: 28, color: Colors.grey[600]),
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
