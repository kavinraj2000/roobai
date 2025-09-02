import 'package:flutter/material.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/model/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        category.categoryImage != null && category.categoryImage!.isNotEmpty;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 70, // ✅ fixed card width
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipOval(
                child: hasImage
                    ? Image.network(
                        category.categoryImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 32, // ✅ fixed height for text so all cards line up
              child: Text(
                category.category ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppConstants.textblack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade100,
      child: const Center(
        child: Icon(Icons.image_outlined, size: 28, color: Colors.grey),
      ),
    );
  }
}
