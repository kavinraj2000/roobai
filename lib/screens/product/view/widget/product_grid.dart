import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/comman/widgets/product_card.dart';

class DealFinderGrid extends StatelessWidget {
  final List<Product> products;
  final List<HomeModel> homemodel;
  final Future<void> Function()? onRefresh;

  const DealFinderGrid({
    super.key,
    required this.products,
    required this.homemodel,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index.isEven) {
                    final leftIndex = index ~/ 2 * 2;
                    final rightIndex = leftIndex + 1;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildProductCard(
                              context,
                              products[leftIndex],
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (rightIndex < products.length)
                            Expanded(
                              child: _buildProductCard(
                                context,
                                products[rightIndex],
                              ),
                            )
                          else
                            const Expanded(child: SizedBox()),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }, childCount: (products.length / 2).ceil() * 2),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        context.goNamed(RouteName.productdetail);
      },
      child: Hero(
        tag: "product_${product.pid}",
        child: ProductCard(
          product: product,
          homemodel: homemodel,
        ),
      ),
    );
  }
}
