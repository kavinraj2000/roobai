import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/model/bannar_model.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
import 'package:roobai/screens/homepage/view/mobile/card.dart';
import 'package:roobai/screens/homepage/view/mobile/categories.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const CustomAppBar(),
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

                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<HomepageBloc>().add(LoadHomepageData()),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (banners.isNotEmpty) _buildBannerCarousel(banners),
                        const SizedBox(height: 16),
                        _buildCategorySection(categories),
                        const SizedBox(height: 20),
                        if (products.isNotEmpty)
                          _buildProductHorizontalList(context,products),
                        const SizedBox(
                          height: 80,
                        ), // Extra space to avoid overflow
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

  // ✅ Banner carousel
  Widget _buildBannerCarousel(List<BannerModel> banners) {
  if (banners.isEmpty) return const SizedBox.shrink();
  return SizedBox(
    height: 180,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: banners.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final banner = banners[index];
        final url = banner.image ?? ''; 
        final producturl = banner.url ?? ''; 
final bannerUrl = banner.url != null
    ? 'https://roobai.com/assets/images/banner/collage/new/$url'
    : '';
Logger().d('_buildBannerCarousel::$bannerUrl');

       return InkWell(
        onTap: (){
          context.read<HomepageBloc>().add(NavigateToProductEvent(producturl));
        },
         child: ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: CachedNetworkImage(
    imageUrl: bannerUrl,
    width: 300,
    fit: BoxFit.cover,
    placeholder: (_, __) => Container(
      color: Colors.grey.shade200,
      child: const Center(child: CircularProgressIndicator()),
    ),
    errorWidget: (_, __, ___) => Container(
      color: Colors.grey.shade200,
      child: const Icon(Icons.broken_image, size: 50),
    ),
  ),
)

       );

      },
    ),
  );
}


  Widget _buildCategorySection(List categories) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('View More', style: AppConstants.textblack),
                  const Icon(Icons.arrow_right, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return SizedBox(
                child: CategoryCard(
                  category: category,
                  onTap: () {
                    // Handle category tap
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductHorizontalList(BuildContext context,List<ProductModel> products) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Justin scroll', style: AppConstants.textblack),
              InkWell(
                onTap: () {
                  context.goNamed(RouteName.product);
                },
                child: Row(
                  children: [
                    Text('View More', style: AppConstants.textblack),
                
                    const Icon(Icons.arrow_right, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 270,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
}
