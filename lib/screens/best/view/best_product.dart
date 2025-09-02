import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/best/bloc/best_products_bloc.dart';
import 'package:roobai/screens/best/repo/best_products_repository.dart';
import 'package:roobai/screens/best/view/mobile/best_products_view.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';


class BestProductpage extends StatelessWidget {
  const BestProductpage({super.key});

  @override
  Widget build(BuildContext context) {
   

    return BlocProvider<BestProductBloc>(
      create: (context) =>
          BestProductBloc(BestproductRepository())..add(FetchproductrData()),
      child: Bestproductview(),
    );
  }
}
