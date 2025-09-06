import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/widgets/datatime_widget.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
        margin: const EdgeInsets.all(6),
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
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
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
                            horizontal: 8,
                            vertical: 2,
                          ),
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
              padding: const EdgeInsets.all(6),
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
                        Text('$discount%', style: AppConstants.textblack),
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
      color: Colors.grey.shade100,
      child: const Center(
        child: Icon(Icons.image_outlined, size: 28, color: Colors.grey),
      ),
    );
  }
}
