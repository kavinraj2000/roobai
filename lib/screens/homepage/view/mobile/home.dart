import 'package:flutter/material.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/features/product/shared/widget/appbarwidget.dart';
import 'package:roobai/features/product/shared/widget/carsoul_slider.dart';
import 'package:roobai/features/product/shared/widget/drawer.dart';
import 'package:roobai/features/product/shared/widget/navbarwidget.dart';
import 'package:roobai/features/product/shared/widget/searchbar.dart';
import 'package:roobai/screens/homepage/view/mobile/card/platform_card.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: CustomDrawer(
        userName: 'Your Name',
        userImageUrl: 'profile_image_url',
        categories: [
          DrawerCategory(title: 'Women', icon: Icons.woman),
          DrawerCategory(title: 'Shoes', icon: Icons.shopping_bag),
        ],
        platforms: [
          DrawerPlatform(
            title: 'amazon',
            backgroundColor: Color(0xFF232F3E),
            textColor: Colors.white,
            subtitle: '20%',
          ),
        ],
      ),
      appBar: const CustomAppBar(title: "Home"),
     
      bottomNavigationBar: const BottomNavBarWidget(
        currentRoute: '/mainscreen',
      ),
      backgroundColor: white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search Bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SimpleSearchBar(
                    onSubmitted: (query) {
                      print("Searching: $query");
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // 🛍️ Horizontal Category Chips
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: white,
                              maxRadius: 30,
                              child: const Icon(
                                Icons.shopping_bag,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Product $index",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // 📦 Platform Section
                const Text(
                  'Platform',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return PlatformCard(
                        imageUrl:
                            "https://play.google.com/store/apps/details?id=com.eshop.ecommerceapp",
                        title: "product",
                        discount: "50%",
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // 🎠 Carousel
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: CarouselSliderWidget(
                      imageUrls: const [
                        "https://img.freepik.com/free-vector/flat-design-shopping-banner-template_23-2148707915.jpg",
                        "https://img.freepik.com/free-vector/sale-banner-template-design_23-2148938951.jpg",
                        "https://img.freepik.com/free-vector/flat-design-ecommerce-banner-template_23-2149044085.jpg",
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
