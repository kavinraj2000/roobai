import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:roobai/screens/homepage/view/mobile/categories.dart';

class CategoryCarousel extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel)? onCategoryTap;

  const CategoryCarousel({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 0.35, // adjust how many cards visible
      ),
      items: categories.map((category) {
        return Builder(
          builder: (BuildContext context) {
            return CategoryCard(
              category: category,
              onTap: () => onCategoryTap?.call(category),
            );
          },
        );
      }).toList(),
    );
  }
}
