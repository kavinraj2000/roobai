import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';

import 'package:roobai/screens/category/bloc/category_bloc.dart';
import 'package:roobai/screens/category/repo/category_repo.dart';
import 'package:roobai/screens/category/view/mobile/category.dart';


class CategoryPage extends StatelessWidget {
  final Map<String,dynamic> initalvalue;
  const CategoryPage({super.key,required this.initalvalue});

  @override
  Widget build(BuildContext context) {
   
Logger().d('CategoryPage:initalvalue::$initalvalue');
    return BlocProvider<CategoryBloc>(
      create: (context) =>
          CategoryBloc(CategoryRepository())..add(Initialvalueevent(initalvalue)),
      child: CategoryViewPage(),
    );
  }
}
