import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/constants/color_constansts.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/datatime_widget.dart';
import 'package:roobai/comman/widgets/loader.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/comman/widgets/no_data.dart';
import 'package:roobai/screens/category/bloc/category_bloc.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';

class CategoryViewPage extends StatelessWidget {
  final CategoryModel? category;

  const CategoryViewPage({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        context.read<CategoryBloc>().add(LoadMoreProductsEvent());
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: category?.category ?? "Category"),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 1),
      backgroundColor: ColorConstants.white,
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.status == CategoryStatus.initial) {
            context.read<CategoryBloc>().add(
              Initialvalueevent({'cid': category?.cid}),
            );
          }

          if (state.status == CategoryStatus.loading && !state.isFetching) {
            return const Center(child: LoadingPage());
          }

          Logger().d('CategoryViewPage::state:${state.dealModel}');

          if (state.status == CategoryStatus.loaded) {
            final products = state.dealModel ?? [];

            if (products.isEmpty) {
              return const Center(child: NoDataWidget());
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<CategoryBloc>().add(
                  RefreshProductsEvent({'cid': category?.cid}),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (category?.category != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        category!.category!,
                        style: GoogleFonts.sora(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 255,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _productCard(context, product);
                      },
                    ),
                  ),

                  if (state.isFetching)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          }

          return const Center(child: NoDataWidget());
        },
      ),
    );
  }
}

Widget _productCard(BuildContext context, ProductModel product) {
  final mrp = double.tryParse(product.productSalePrice ?? '') ?? 0;
  final offer = double.tryParse(product.productOfferPrice ?? '') ?? 0;
  final discount = mrp > 0 ? (((mrp - offer) / mrp) * 100).round() : 0;
  final isExpired = product.stockStatus?.toString() == '1';

  return InkWell(
    onTap: () {
      context.read<HomepageBloc>().add(
        NavigateToProductEvent(product.productUrl),
      );
    },
    child: Container(
      width: 180,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: product.productImage != null &&
                          product.productImage!.isNotEmpty
                      ? Image.network(
                          product.productImage!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),
                if (isExpired || discount >= 80)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: isExpired ? Colors.red : Colors.deepPurple,
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
                        child: Text(
                          isExpired ? 'Expired' : 'G.O.A.T',
                          style: AppConstants.headerwhite,
                        ),
                      ),
                    ),
                  ),

                if (product.storeName != null && product.storeName!.isNotEmpty)
                  Positioned(
                    bottom: 4,
                    left: 4,
                    right: 4,
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5DC02),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              product.storeName!,
                              style: GoogleFonts.sora(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName ?? 'Product',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppConstants.headerblack,
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Text(
                        '₹${offer.toStringAsFixed(0)}',
                        style: AppConstants.headerblack,
                      ),
                      const SizedBox(width: 6),
                      if (mrp > 0)
                        Text(
                          '₹${mrp.toStringAsFixed(0)}',
                          style: AppConstants.offer,
                        ),
                      const Spacer(),
                      if (discount > 0)
                        Stack(
                          alignment: AlignmentGeometry.centerLeft,

                          children: [
                            
                            Row(
                              children: [
                                Text(
                                  '$discount%',
                                  style: AppConstants.textblack,
                                ),
                                const SizedBox(width: 4),
                                Image.asset(
                                  'assets/icons/thunder.png',
                                  height: 14,
                                  color: _getThunderColor(discount),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),

                  // if (product.dateTime != null)
                  //   Datetimewidget(dateTime: product.dateTime),
                ],
              ),
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

Color _getThunderColor(int discount) {
  if (discount >= 80) {
    return Colors.green;
  } else if (discount >= 50) {
    return Colors.blue;
  } else if (discount >= 25) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
