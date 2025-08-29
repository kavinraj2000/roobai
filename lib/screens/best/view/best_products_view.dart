import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/color_constansts.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/screens/best/bloc/best_products_bloc.dart';
import 'package:roobai/screens/best/view/widget/product_empty.dart';
import 'package:roobai/screens/best/view/widget/product_error.dart';
import 'package:roobai/screens/best/view/widget/product_grid.dart';
import 'package:roobai/screens/best/view/widget/product_loading.dart';
import 'package:roobai/screens/product/view/widget/product_empty.dart';
import 'package:roobai/screens/product/view/widget/product_error.dart';
import 'package:roobai/screens/product/view/widget/product_grid.dart';
import 'package:roobai/screens/product/view/widget/product_loading.dart';


class Bestproductview extends StatelessWidget {
  const Bestproductview({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: CustomAppBar(),
    bottomNavigationBar: BottomNavBarWidget(selectedIndex:1, ),
    backgroundColor:ColorConstants.white,
    body:  BlocBuilder<BestProductBloc, BestProductState>(
      builder: (context, state) {
        Logger().d('state::product:url::${state.dealModel?.first.shareUrl}');
        switch (state.status) {
          case BestProductStatus.loading:
            return const BestProductLoading();
          case BestProductStatus.loaded:
            final products = state.dealModel ?? [];
            if (products.isEmpty) {  
              return const BestProductempty();
            }
            return BestProductGrid(products: products,);
          case BestProductStatus.failure:
            return BestProductError(
              message: state.message ?? "Unknown error occurred",
              onRetry: () {
                context.read<BestProductBloc>().add(FetchproductrData(isInitialLoad: false));
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