import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/drawer/view/drawer_cat.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/datatime_widget.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';

class ProductmobileView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductmobileView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: const CustomDrawerWidget(),
      bottomNavigationBar: const BottomNavBarWidget(selectedIndex: 0),
      body: products.isEmpty
          ? const Center(
              child: Text(
                'No products available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 per row
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.65, // poster style
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final mrp = double.tryParse(product.productSalePrice ?? '') ?? 0;
                final offer = double.tryParse(product.productOfferPrice ?? '') ?? 0;
                final discount =
                    mrp > 0 ? (((mrp - offer) / mrp) * 100).round() : 0;
                final isExpired = product.stockStatus?.toString() == '1';

                return InkWell(
                  onTap: () {
                    context
                        .read<HomepageBloc>()
                        .add(NavigateToProductEvent(product.productUrl));
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
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
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
                                ],
                              ),
                              if (discount > 0)
                                Text('$discount% OFF',
                                    style: AppConstants.textblack),
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
              },
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
}
