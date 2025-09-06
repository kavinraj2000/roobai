import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/best/bloc/best_products_bloc.dart';
import 'package:roobai/screens/best/repo/best_products_repository.dart';
import 'package:roobai/screens/best/view/mobile/best_products_view.dart';
import 'package:roobai/screens/category/bloc/category_bloc.dart';
import 'package:roobai/screens/category/repo/category_repo.dart';

class CategoryPage extends StatelessWidget {
  final Map<dynamic, String> initalvalue;
  const CategoryPage({super.key, required this.initalvalue});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) =>
          CategoryBloc(CategoryRepository())..add(Initialvalueevent()),
      child: Bestproductview(),
    );
  }
}
