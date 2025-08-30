import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/color_constansts.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
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
    bottomNavigationBar: BottomNavBarWidget(selectedIndex:2, ),
    backgroundColor:ColorConstants.white,
    body:  BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        Logger().d('state::product:url::${state.dealModel?.first.shareUrl}');
        switch (state.status) {
          case DealfinderStatus.loading:
            return const DealFinderLoading();
          case DealfinderStatus.loaded:
            final products = state.dealModel ?? [];
            final HomeModel = state.homemodel ?? [];
            if (products.isEmpty) {  
              return const DealFinderEmpty();
            }
            return DealFinderGrid(products: products,homemodel: HomeModel,);
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