import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roobai/comman/constants/color_constansts.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/comman/widgets/no_data.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
import 'package:roobai/screens/product/view/widget/Product_datetime.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 0),
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state.status == HomepageStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          if (state.status == HomepageStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 24),
                  Padding(padding: EdgeInsets.all(16), child: NoDataWidget()),
                  const SizedBox(height: 8),
                  // Text(
                  //   state.errorMessage ?? 'Please try again',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.grey.shade600,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 24),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     context.read<HomepageBloc>().add(LoadHomepageData());
                  //   },
                  //   icon: const Icon(Icons.refresh),
                  //   label: const Text('Retry'),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.blue,
                  //     foregroundColor: Colors.white,
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 24,
                  //       vertical: 12,
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }

          if (state.status == HomepageStatus.loaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomepageBloc>().add(LoadHomepageData());
              },
              color: Colors.blue,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    ...state.homeModel
                        .map((homeModel) => _buildSection(context, homeModel))
                        .toList(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, HomeModel homeModel) {
    switch (homeModel.type) {
      case 'big_cat':
        return _buildBigCategorySection(homeModel);
      case 'banner':
        return _buildBannerSection(homeModel);
      case 'category':
        return _buildCategorySection(homeModel);
      default:
        return _buildDefaultSection(homeModel);
    }
  }

  Widget _buildBigCategorySection(HomeModel homeModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: homeModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              final data = homeModel.data![index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {},
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: data.img_url ?? '',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            // color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(Icons.error, size: 50),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.black.withOpacity(0.4),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Text(
                              data.category ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBannerSection(HomeModel homeModel) {
    if (homeModel.data == null || homeModel.data!.isEmpty) {
      return const SizedBox.shrink();
    }

    final imageUrls = homeModel.data!
        .map((data) => data.image1 ?? data.image ?? '')
        .where((url) => url.isNotEmpty)
        .toList();

    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: imageUrls.length > 1,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayInterval: const Duration(seconds: 4),
            ),
            items: imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCategorySection(HomeModel homeModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _buildSectionHeader(homeModel.title ?? ''),
        // const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: homeModel.data?.length ?? 0,
            separatorBuilder: (context, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final data = homeModel.data![index];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        (data.category_image != null &&
                            data.category_image!.isNotEmpty)
                        ? NetworkImage(data.category_image!)
                        : null,
                    child:
                        (data.category_image == null ||
                            data.category_image!.isEmpty)
                        ? const Icon(
                            Icons.category,
                            size: 24,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 60,
                    child: Text(
                      data.category ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDefaultSection(HomeModel homeModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (homeModel.title != null && homeModel.title!.isNotEmpty)
          _buildSectionHeader(homeModel.title!),

        const SizedBox(height: 8),

        SizedBox(
          height: 271,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: homeModel.data?.length ?? 0,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final data = homeModel.data![index];

              final mrp = double.tryParse(data.productSalePrice ?? '') ?? 0;
              final offerPrice =
                  double.tryParse(data.productOfferPrice ?? '') ?? 0;
              final discount = (mrp > 0)
                  ? (((mrp - offerPrice) / mrp) * 100).round()
                  : 0;

              return Container(
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section
                    Stack(
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: data.productImage ?? '',
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(
                                color: Colors.grey.shade100,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              errorWidget: (_, __, ___) => Container(
                                color: Colors.grey.shade100,
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // GOAT Badge
                        if (discount >= 80)
                        // GOAT badge + Image section
Column(
  children: [
    if (discount >= 80)
      Container(
        margin: const EdgeInsets.only(bottom: 4), // spacing below badge
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'G.O.A.T',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: data.productImage ?? '',
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            color: Colors.grey.shade100,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.grey,
              ),
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            color: Colors.grey.shade100,
            child: const Center(
              child: Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: 32,
              ),
            ),
          ),
        ),
      ),
    ),
  ],
),

                      ],
                    ),

                    if (data.storeName != null)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade400,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.amber.shade700,
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            data.storeName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 8,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name
                            Text(
                              data.productName ?? 'Product',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.2,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Price Section
                            Row(
                              children: [
                                Text(
                                  '₹${data.productOfferPrice ?? ''}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                if (data.productSalePrice != null)
                                  Text(
                                    '₹${data.productSalePrice}',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),

                                if (discount > 0) ...[
                                  const SizedBox(width: 4),
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade600,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "$discount% OFF",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),

                            if (data.dateTime != null) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: Datetimewidget(
                                      dateTime: data.dateTime,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            elevation: 16,
                                            backgroundColor: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: IntrinsicHeight(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.info,
                                                          color: Colors.blue,
                                                          size: 24,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            data.productName ??
                                                                "Product Details",
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      height: 1,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Flexible(
                                                      child: SingleChildScrollView(
                                                        child: Text(
                                                          data.itext ??
                                                              "No description available.",
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black87,
                                                                height: 1.4,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: ElevatedButton.icon(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                              context,
                                                            ).pop(),
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 18,
                                                        ),
                                                        label: const Text(
                                                          "Close",
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 16,
                                                                vertical: 10,
                                                              ),
                                                          backgroundColor:
                                                              Colors.blue,
                                                          foregroundColor:
                                                              Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.info,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //   },
          //   child: Text(
          //     'View All',
          //     style: TextStyle(
          //       color: Colors.blue.shade600,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
