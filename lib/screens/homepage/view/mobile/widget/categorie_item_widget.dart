// widgets/category_item_widget.dart
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const CategoryItemWidget({
    super.key,
    required this.name,
    this.imageUrl,
    this.icon,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.shopping_bag,
                            color: Colors.grey[600],
                            size: 30,
                          );
                        },
                      ),
                    )
                  : Icon(
                      icon ?? Icons.shopping_bag,
                      color: Colors.grey[600],
                      size: 30,
                    ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 60,
              height: 32,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
