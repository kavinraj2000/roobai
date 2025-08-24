import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:roobai/comman/constants/color_constansts.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/carsoul_slider.dart';
import 'package:roobai/comman/widgets/loader.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/comman/widgets/searchbar.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
import 'package:roobai/screens/homepage/view/mobile/card/platform_card.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger();
    return Scaffold(
      appBar: const CustomAppBar(title: "Home"),
      bottomNavigationBar: const BottomNavBarWidget(
        currentRoute: '/mainscreen',
      ),
      backgroundColor: ColorConstants.white,
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (BuildContext context, HomepageState state) {
          if (state.status == HomepageStatus.loading) {
            return const LoadingPage();
          }

          log.d('Homepage::state::${state.homeModel}');

          if (state.status == HomepageStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage ?? "Failed to load data",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomepageBloc>().add(LoadHomepageData());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final homeModels = state.homeModel ?? [];

          if (homeModels.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No data available",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SimpleSearchBar(
                        onSubmitted: (query) {
                          print("Searching: $query");
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildCategoriesSection(homeModels),
                    const SizedBox(height: 20),

                    ...homeModels.map(
                      (homeModel) => _buildHomeSection(homeModel),
                    ),

                    _buildCarouselSection(homeModels),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection(List<HomeModel> homeModels) {
    final categories = _extractCategories(homeModels);

    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    print("Category selected: ${category.category}");
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        maxRadius: 30,
                        backgroundImage:
                            category.category_image != null &&
                                category.category_image!.isNotEmpty
                            ? NetworkImage(category.category_image!)
                            : null,
                        child:
                            category.category_image == null ||
                                category.category_image!.isEmpty
                            ? const Icon(Icons.shopping_bag, color: Colors.grey)
                            : null,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 70,
                        child: Text(
                          category.category ?? 'Category',
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHomeSection(HomeModel homeModel) {
    if (homeModel.data == null || homeModel.data!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          homeModel.title ?? 'Section',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        if (homeModel.type == 'banner')
          _buildBannerSection(homeModel.data!)
        else if (homeModel.type == 'product' || homeModel.type == 'platform')
          _buildProductSection(homeModel.data!)
        else
          _buildDefaultSection(homeModel.data!),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBannerSection(List<Data> banners) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                print("Banner tapped: ${banner.url}");
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: _getBannerImage(banner) != null
                      ? Image.network(
                          _getBannerImage(banner)!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(
                              banner.bannerName ?? 'Banner',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductSection(List<Data> products) {
    return SizedBox(
      height: 220, // Increased height to accommodate content
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return PlatformCard(
            productData: product, // Pass individual product data
            discount: _calculateDiscount(
              product.productSalePrice,
              product.productOfferPrice,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDefaultSection(List<Data> items) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                print("Item tapped: ${item.productName ?? item.bannerName}");
              },
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_getItemImage(item) != null)
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          child: Image.network(
                            _getItemImage(item)!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported);
                            },
                          ),
                        ),
                      )
                    else
                      const Expanded(
                        child: Icon(Icons.image_not_supported, size: 40),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.productName ?? item.bannerName ?? 'Item',
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarouselSection(List<HomeModel> homeModels) {
    final bannerImages = homeModels[0].data![0].productImage;

    for (final homeModel in homeModels) {
      if (homeModel.type == 'banner' && homeModel.data != null) {
        for (final data in homeModel.data!) {
          final imageUrl = _getBannerImage(data);
          if (imageUrl != null) {
            bannerImages! ;
          }
        }
      }
    }

    final carouselImages = bannerImages!.isNotEmpty
        ? bannerImages
        : ['${homeModels[0].data![0].image1}'];

    // if (carouselImages!) {
    //   return const SizedBox.shrink();
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: SizedBox(
        //     height: 180,
        //     width: double.infinity,
        //     child: CarouselSliderWidget(imageUrls: homeModels,
        //     )
        //   ),
        // ),
      ],
    );
  }

  // Helper methods
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
          }
        }
      }
    }

    return categories;
  }

  String _calculateDiscount(String? salePrice, String? offerPrice) {
    if (salePrice == null ||
        offerPrice == null ||
        salePrice.isEmpty ||
        offerPrice.isEmpty) {
      return '';
    }

    try {
      final sale = double.parse(salePrice);
      final offer = double.parse(offerPrice);
      if (sale > offer && offer > 0) {
        final discount = ((sale - offer) / sale * 100).round();
        return '$discount%';
      }
    } catch (e) {
      print('Error calculating discount: $e');
    }

    return '';
  }

  String? _getBannerImage(Data banner) {
    if (banner.image != null && banner.image!.isNotEmpty) {
      return banner.image!;
    }
    if (banner.image1 != null && banner.image1!.isNotEmpty) {
      return banner.image1!;
    }
    if (banner.img_url != null && banner.img_url!.isNotEmpty) {
      return banner.img_url!;
    }
    return null;
  }

  String? _getItemImage(Data item) {
    if (item.productImage != null && item.productImage!.isNotEmpty) {
      return item.productImage!;
    }
    if (item.image != null && item.image!.isNotEmpty) {
      return item.image!;
    }
    if (item.img_url != null && item.img_url!.isNotEmpty) {
      return item.img_url!;
    }
    if (item.image1 != null && item.image1!.isNotEmpty) {
      return item.image1!;
    }
    return null;
  }
}
