import 'package:flutter/material.dart';
import 'package:roobai/features/product/data/model/home_model.dart';
import 'package:roobai/features/product/shared/widget/appbarwidget.dart';
import 'package:roobai/features/product/shared/widget/carsoul_slider.dart';
import 'package:roobai/features/product/shared/widget/navbarwidget.dart';
import 'package:roobai/features/product/shared/widget/searchbar.dart';
import 'package:roobai/screens/mainscreen/product/view/products.dart';
import 'package:roobai/screens/mainscreen/product/view/products_view.dart';

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
    _initializeHomeData();
  }

  void _initializeHomeData() {
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
          image: "https://images.unsplash.com/photo-1580910051073-31c8f6f8f92f",
          category: "Mobiles",
          cat_slug: "mobiles",
          category_image: "https://cdn-icons-png.flaticon.com/512/597/597177.png",
        ),
        Data(
          bannerId: "3",
          bannerName: "Audio",
          image: "https://images.unsplash.com/photo-1594007654729-d52e9a810a46",
          category: "Audio",
          cat_slug: "audio",
          category_image: "https://cdn-icons-png.flaticon.com/512/727/727245.png",
        ),
        Data(
          bannerId: "4",
          bannerName: "Watches",
          image: "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
          category: "Watches",
          cat_slug: "watches",
          category_image: "https://cdn-icons-png.flaticon.com/512/2917/2917999.png",
        ),
        Data(
          bannerId: "5",
          bannerName: "Cameras",
          image: "https://images.unsplash.com/photo-1519183071298-a2962be90b8e",
          category: "Cameras",
          cat_slug: "cameras",
          category_image: "https://cdn-icons-png.flaticon.com/512/2920/2920105.png",
        ),
        Data(
          bannerId: "6",
          bannerName: "Accessories",
          image: "https://images.unsplash.com/photo-1600185365483-26c446fc9d49",
          category: "Accessories",
          cat_slug: "accessories",
          category_image: "https://cdn-icons-png.flaticon.com/512/3184/3184760.png",
        ),
      ],
    );
  }

  List<String> getBannerImages() {
    return homeModel?.data
            ?.where((item) => item.image != null && item.image!.isNotEmpty)
            .map((e) => e.image!)
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    if (homeModel == null) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Loading..."),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const Appbarwidget(),
      bottomNavigationBar: const BottomNavBarWidget(currentRoute: 'home'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
              Colors.purple.shade50,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Enhanced Search Bar
              const SearchBarWidget(),
              const SizedBox(height: 24),
              // Categories Section
              _buildCategoriesSection(context),
              const SizedBox(height: 24),
              // Carousel Section
              _buildCarouselSection(),
              const SizedBox(height: 32),
              // Featured Products Section
              _buildFeaturedProductsSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final categories = homeModel?.data
            ?.where((item) =>
                item.category != null &&
                item.cat_slug != null &&
                item.category_image != null)
            .toList() ??
        [];

    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.category,
                color: Colors.deepPurple,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return _buildCategoryCard(context, cat, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(BuildContext context, Data category, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + (index * 50)),
      child: GestureDetector(
        onTap: () {
          // Navigate to category page
          // context.push('/category/${category.cat_slug}');
        },
        child: Container(
          width: 90,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.network(
                  category.category_image!,
                  height: 32,
                  width: 32,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.category,
                    size: 32,
                    color: Colors.deepPurple.shade300,
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 32,
                      width: 32,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.deepPurple.shade300,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  category.category ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselSection() {
    final bannerImages = getBannerImages();
    
    if (bannerImages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.campaign,
                color: Colors.deepPurple,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Featured Offers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CarouselSliderWidget(imageUrls: bannerImages),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.stars,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all products
                  // context.push('/products');
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 600, // Fixed height to prevent overflow
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Productpage(), // Your corrected DealFinderView
          ),
        ),
      ],
    );
  }
}