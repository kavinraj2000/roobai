import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';
import 'package:roobai/screens/product%20view/bloc/protuct_view_bloc.dart';
import 'package:roobai/screens/product%20view/view/mobil/products_mobile_view.dart';

class Productviewpage extends StatelessWidget {
  const Productviewpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductViewBloc>(
      create: (context) =>
          ProductViewBloc(HomepageRepository())..add(LoadProductViewData()),
      child: ProductmobileView(),
    );
  }
}
