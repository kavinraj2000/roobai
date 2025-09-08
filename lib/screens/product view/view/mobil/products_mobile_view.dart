import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/datatime_widget.dart';
import 'package:roobai/comman/widgets/loader.dart';
import 'package:roobai/comman/widgets/no_data.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/screens/product%20view/bloc/protuct_view_bloc.dart';

class ProductmobileView extends StatefulWidget {
  const ProductmobileView({super.key});

  @override
  State<ProductmobileView> createState() => _ProductmobileViewState();
}

class _ProductmobileViewState extends State<ProductmobileView> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    scrollController.addListener(() {
      final state = context.read<ProductViewBloc>().state;
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.9 &&
          !state.hasReachedMax &&
          state.status != ProductViewStatus.loading) {
        context.read<ProductViewBloc>().add(LoadProductViewData());
      }
    });

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 0),
      body: Stack(
        children: [
          BlocConsumer<ProductViewBloc, ProductviewState>(
            listener: (context, state) {
            },
            builder: (context, state) {
final products = state.justscroll; // assume you store selected category in bloc



              if (state.status == ProductViewStatus.loading &&
                  products.isEmpty) {
                return const Center(child: LoadingPage());
              }

              if (state.status == ProductViewStatus.error && products.isEmpty) {
                return const Center(child: NoDataWidget());
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductViewBloc>().add(RefreshProducts([]));
                },
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = products[index];
                            return _buildProductCard(context, product);
                          },
                          childCount: products.length,
                        ),
                      ),
                    ),
                    if (state.status == ProductViewStatus.loading &&
                        products.isNotEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: SafeArea(
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => context.goNamed(RouteName.mainScreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, dynamic product) {
    final mrp = double.tryParse(product.productSalePrice ?? '') ?? 0;
    final offer = double.tryParse(product.productOfferPrice ?? '') ?? 0;
    final discount = mrp > 0 ? (((mrp - offer) / mrp) * 100).round() : 0;
    final isExpired = product.stockStatus?.toString() == '1';

    return InkWell(
      onTap: () {
        context.read<ProductViewBloc>().add(
              NavigatetoProducturl(product.productPageUrl),
            );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: product.productImage != null &&
                            product.productImage!.isNotEmpty
                        ? Image.network(
                            product.productImage!,
                            fit: BoxFit.contain,
                            width: double.infinity,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
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
                      Text('₹${offer.toStringAsFixed(0)}',
                          style: AppConstants.headerblack),
                      const SizedBox(width: 6),
                      if (mrp > 0)
                        Text('₹${mrp.toStringAsFixed(0)}',
                            style: AppConstants.offer),
                      const Spacer(),
                      if (discount > 0)
                        Row(
                          children: [
                            Text('$discount%', style: AppConstants.textblack),
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
                  if (product.dateTime != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Datetimewidget(dateTime: product.dateTime),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.image_outlined, size: 32, color: Colors.grey),
      ),
    );
  }

  Color _getThunderColor(int discount) {
    if (discount >= 80) return Colors.green;
    if (discount >= 50) return Colors.blue;
    if (discount >= 25) return Colors.orange;
    return Colors.red;
  }
}
