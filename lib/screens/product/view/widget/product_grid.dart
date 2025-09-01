import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/comman/widgets/product_card.dart';

class DealFinderGrid extends StatelessWidget {
  final List<Product> products;
  final Future<void> Function()? onRefresh;

  const DealFinderGrid({
    super.key,
    required this.products,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final log=Logger();
    if (products.isEmpty) {
      return const Center(child: Text("No products available."));
    }
log.d('DealFinderGrid::state::$products');
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async { debugPrint("No refresh function provided"); },
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
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final leftIndex = index * 2;
                    final rightIndex = leftIndex + 1;

                    if (leftIndex >= products.length) return null;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildProductCard(context, products[leftIndex]),
                          ),
                          const SizedBox(width: 8),
                          if (rightIndex < products.length)
                            Expanded(child: _buildProductCard(context, products[rightIndex]))
                          else
                            const Expanded(child: SizedBox()),
                        ],
                      ),
                    );
                  },
                  childCount: (products.length / 2).ceil(),
                ),
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
      onTap: () => context.goNamed(RouteName.productdetail, extra: product),
      child: Hero(
        tag: "product_${product.pid}",
        child: ProductCard(product: product),
      ),
    );
  }
}
