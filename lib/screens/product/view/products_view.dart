import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/features/product/shared/widget/appbarwidget.dart';
import 'package:roobai/features/product/shared/widget/navbarwidget.dart';
import 'package:roobai/screens/product/bloc/products_bloc.dart';
import 'package:roobai/screens/product/view/widget/product_empty.dart';
import 'package:roobai/screens/product/view/widget/product_error.dart';
import 'package:roobai/screens/product/view/widget/product_grid.dart';
import 'package:roobai/screens/product/view/widget/product_loading.dart';


class DealFinderView extends StatelessWidget {
  const DealFinderView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: CustomAppBar(),
    bottomNavigationBar: BottomNavBarWidget(currentRoute: 'product',), 
    backgroundColor: white,
    body:  BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        Logger().d('state::product:url::${state.dealModel?.first.shareUrl}');
        switch (state.status) {
          case DealfinderStatus.loading:
            return const DealFinderLoading();
          case DealfinderStatus.loaded:
            final products = state.dealModel ?? [];
            if (products.isEmpty) {  
              return const DealFinderEmpty();
            }
            return DealFinderGrid(products: products);
          case DealfinderStatus.failure:
            return DealFinderError(
              message: state.message ?? "Unknown error occurred",
              onRetry: () {
                context.read<ProductBloc>().add(FetchDealFinderData());
              },
            );
          default:
            return const SizedBox.shrink();
        }
      }
     ),
    );
  }
}