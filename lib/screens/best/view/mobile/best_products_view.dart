import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/color_constansts.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/loader.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/comman/widgets/no_data.dart';
import 'package:roobai/screens/best/bloc/best_products_bloc.dart';

import 'package:roobai/screens/best/view/mobile/widget/product_grid.dart';

class Bestproductview extends StatelessWidget {
  const Bestproductview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 1),
      backgroundColor: ColorConstants.white,
      body: BlocBuilder<BestProductBloc, BestProductState>(
        builder: (context, state) {
          Logger().d('state::product:url::${state.dealModel?.first.shareUrl}');
          if (state.status == BestProductStatus.loading) {
            return Center(child: LoadingPage());
          }

          if (state.status == BestProductStatus.loaded) {
            final products = state.dealModel ?? [];
            final homedata=state.homemodel ?? [];
            return BestProductGrid(products: products,homemodel: homedata,);
          }
          if (state.status == BestProductStatus.failure) {
            return Center(child: NoDataWidget());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
