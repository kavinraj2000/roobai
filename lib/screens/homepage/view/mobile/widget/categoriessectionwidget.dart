// widgets/categories_section_widget.dart
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/screens/homepage/view/mobile/widget/categorie_item_widget.dart';

class CategoriesSectionWidget extends StatelessWidget {
  final List<HomeModel> homeModels;
  final VoidCallback? onViewAllTapped;

  const CategoriesSectionWidget({
    super.key,
    required this.homeModels,
    this.onViewAllTapped,
  });

  @override
  Widget build(BuildContext context) {
    final categories = _extractCategories(homeModels);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                if (categories.isNotEmpty) {
                  final category = categories[index];
                  return CategoryItemWidget(
                    name: category.category ?? 'Category',
                    imageUrl: category.category_image,
                    onTap: () => print("Category selected: ${category.category}"),
                  );
                } else {
                  Logger().d('no category images::::$categories');
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Data> _extractCategories(List<HomeModel> homeModels) {
    final categories = <Data>[];
    final seenCategories = <String>{};

    for (final homeModel in homeModels) {
      if (homeModel.data != null) {
        for (final data in homeModel.data!) {
          if (data.category != null &&
              data.category!.isNotEmpty &&
              !seenCategories.contains(data.category)) {
            categories.add(data);
            seenCategories.add(data.category!);
        Logger().d('data::homemodel::$seenCategories');
          }
        }
      }
    }

    return categories;
  }
}