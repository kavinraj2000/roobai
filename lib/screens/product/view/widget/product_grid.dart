import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product/view/widget/product_card.dart';

class DealFinderGrid extends StatelessWidget {
  final List<Product> products;

  const DealFinderGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
              }, childCount: (products.length / 2).ceil()),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => ProductDetailScreen(product: product),
        //   ),
        // );
        context.goNamed(RouteName.productdetail);
      },
      child: Hero(
        tag: "product_${product.pid}",
        child: ProductCard(product: product),
      ),
    );
  }
}
