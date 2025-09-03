import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  // Enhanced color palette with more vibrant but still light colors
  static const List<Color> backgroundColors = [
    Color(0xFFE8F5E9), // Light green
    Color(0xFFE3F2FD), // Light blue
    Color(0xFFFFF8E1), // Light amber
    Color(0xFFF3E5F5), // Light purple
    Color(0xFFFFEBEE), // Light pink
    Color(0xFFE0F7FA), // Light cyan
    Color(0xFFE8F5E8), // Pale green
    Color(0xFFFFF3E0), // Light orange
    Color(0xFFE0F2F1), // Light teal
    Color(0xFFF1F8E9), // Light lime
    Color(0xFFEDE7F6), // Light deep purple
    Color(0xFFFFFDE7), // Light yellow
    Color(0xFFEFEBE9), // Light brown
    Color(0xFFE8EAF6), // Light indigo
  ];

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://roobai.com/assets/img/sale_cat_img/${category.categoryImage}';
    Logger().d('Image URL: $imageUrl');
    
    final colorIndex = (category.category?.hashCode ?? 0).abs() % backgroundColors.length;
    final backgroundColor = backgroundColors[colorIndex];
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image container with better error handling
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color:backgroundColor,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                // width: 60,
                // height: 60,
                fit: BoxFit.contain, 
                placeholder: (context, url) => Container(
                  color: Colors.white.withOpacity(0.7),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => _placeholder(),
              ),
            ),
          ),
          // Text with improved styling
          Container(
            // height: 36,
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              category.category ?? 'Unnamed',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.textblack
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
      ),
      child: Center(
        child: Icon(Icons.category_outlined, size: 28, color: Colors.grey[400]),
      ),
    );
  }
}