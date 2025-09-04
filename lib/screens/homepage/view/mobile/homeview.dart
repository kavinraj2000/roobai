import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/drawer/view/drawer.dart';
import 'package:roobai/comman/drawer/view/drawer_cat.dart';
import 'package:roobai/comman/helper/drawercategory.dart';
import 'package:roobai/comman/model/bannar_model.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/hour_header_widget.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
import 'package:roobai/screens/homepage/view/mobile/card.dart';
import 'package:roobai/screens/homepage/view/mobile/categories.dart';
import 'package:roobai/screens/homepage/view/mobile/hourdeal_card.dart';
import 'package:roobai/screens/homepage/view/mobile/mobil_category.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      
      drawer: Drawerwidget(),
       floatingActionButton: FloatingActionButton(
    backgroundColor: const Color(0xFF8B5CF6),
    onPressed: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => const Drawerwidget(),
      );
    },
       ),
      
      bottomNavigationBar: const BottomNavBarWidget(selectedIndex: 0),
      body: SafeArea(
        child: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            switch (state.status) {
              case HomepageStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );

              case HomepageStatus.error:
                return const Center(
                  child: Text(
                    "Failed to load data",
                    style: TextStyle(color: Colors.red),
                  ),
                );

              case HomepageStatus.loaded:
                final products = state.justscroll ?? [];
                final categories = state.category ?? [];
                final banners = state.banner ?? [];
                final hourdeal = state.hourdeals ?? [];
                final mobile = state.mobileList ?? [];

                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<HomepageBloc>().add(LoadHomepageData()),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBannerCarousel(banners, context),
                        const SizedBox(height: 16),
                        _buildCategorySection(categories),
                        const SizedBox(height: 20),
                        if (products.isNotEmpty)
                          _buildProductHorizontalList(context, products),
                        const SizedBox(height: 20),
                        if (hourdeal.isNotEmpty)
                          _buildHourDeals(context, hourdeal),
                        const SizedBox(height: 20),
                        if (mobile.isNotEmpty)
                          _buildMobileHorizontalList(context, mobile),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  // 1. BANNER SECTION
  Widget _buildBannerCarousel(List<BannerModel> banners, BuildContext context) {
    if (banners.isEmpty) {
      return Container(
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'No banners available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: CarouselSlider.builder(
        itemCount: banners.length,
        options: CarouselOptions(
          height: 180,
          autoPlay: banners.length > 1,
          enlargeCenterPage: true,
          viewportFraction: 0.85,
        ),
        itemBuilder: (context, index, realIndex) {
          final banner = banners[index];
          final imageUrl = banner.image?.isNotEmpty == true
              ? 'https://roobai.com/assets/images/banner/collage/new/${banner.image}'
              : '';
          final productUrl = banner.url ?? "";

          return InkWell(
            onTap: () {
              if (productUrl.isNotEmpty) {
                context.read<HomepageBloc>().add(
                  NavigateToProductEvent(productUrl),
                );
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (_, __, ___) =>
                          const Center(child: Icon(Icons.broken_image)),
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 40),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  // 2. CATEGORY SECTION
  Widget _buildCategorySection(List categories) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryCard(category: category, onTap: () {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductHorizontalList(
    BuildContext context,
    List<ProductModel> products,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Just Scroll',
                style:
                    AppConstants.textblack?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              InkWell(
                onTap: () => context.goNamed(RouteName.product),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: const [
                      Text(
                        'View More',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 270,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 4, right: 4),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  ProductCard(product: products[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileHorizontalList(
    BuildContext context,
    List<ProductModel> products,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mobile',
                style:
                    AppConstants.textblack?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              InkWell(
                onTap: () => context.goNamed(RouteName.product),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: const [
                      Text(
                        'View More',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 270,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 4, right: 4),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  MobileCard(product: products[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourDeals(BuildContext context, List<ProductModel> products) {
    if (products.isEmpty) return const SizedBox.shrink();

    final dealEndTime = getDealEndTime(products.first);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage("assets/icons/background.jpg"),
          fit: BoxFit.cover,
          // opacity: 0.15,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 30, // smaller base height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Positioned(
                top: -11,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.redAccent],
                        tileMode: TileMode.mirror,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: HourDealHeader(endTime: dealEndTime),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 10,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return HoursdealCard(product: product, onTap: () {});
              },
            ),
          ),
        ],
      ),
    );
  }

  DateTime getDealEndTime(ProductModel product) {
    try {
      if (product.dateTime != null && product.dateTime!.isNotEmpty) {
        return DateTime.parse(product.dateTime!);
      }
    } catch (_) {}
    // Fallback to 1 hour from now
    return DateTime.now().add(const Duration(hours: 1));
  }
}
