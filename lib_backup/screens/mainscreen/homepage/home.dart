import 'package:flutter/material.dart';
import 'package:roobai/features/product/data/model/home_model.dart';
import 'package:roobai/features/product/shared/widget/appbarwidget.dart';
import 'package:roobai/features/product/shared/widget/carsoul_slider.dart';
import 'package:roobai/features/product/shared/widget/navbarwidget.dart';
import 'package:roobai/features/product/shared/widget/searchbar.dart';
import 'package:roobai/screens/mainscreen/products/product_grid.dart';

import '../../../core/theme/constants.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeModel? homeModel;

  @override
  void initState() {
    super.initState();

    // Simulated data - replace with API call later
    homeModel = HomeModel(
      title: "Home",
      type: "homepage",
      data: [
        Data(
          bannerId: "1",
          bannerName: "Summer Sale",
          image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
          category: "Laptops",
          cat_slug: "laptops",
          category_image: "https://cdn-icons-png.flaticon.com/512/201/201623.png",
        ),
        Data(
          bannerId: "2",
          bannerName: "Mobiles",
          image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
          category: "Mobiles",
          cat_slug: "mobiles",
          category_image: "https://cdn-icons-png.flaticon.com/512/597/597177.png",
        ),
        Data(
          bannerId: "3",
          bannerName: "Audio",
          image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
          category: "Audio",
          cat_slug: "audio",
          category_image: "https://cdn-icons-png.flaticon.com/512/727/727245.png",
        ),
      ],
    );
  }

  List<String> getBannerImages() {
    return homeModel?.data
            ?.where((item) => item.image != null)
            .map((e) => e.image!)
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    if (homeModel == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: const Appbarwidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBarWidget(currentRoute: 'home'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const SearchBarWidget(),
            const SizedBox(height: 16),
            category(context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CarouselSliderWidget(imageUrls: getBannerImages()),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Featured Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            const ProductGrid(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget category(BuildContext context) {
    final categories = homeModel?.data
            ?.where((item) =>
                item.category != null &&
                item.cat_slug != null &&
                item.category_image != null)
            .toList() ??
        [];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            width: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(200),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  cat.category_image!,
                  height: 28,
                  width: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  cat.category ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
