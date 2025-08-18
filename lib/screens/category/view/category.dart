import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/category/bloc/category_bloc.dart';
import 'package:roobai/screens/category/repo/category_repository.dart';
import 'package:roobai/screens/category/view/category_list.dart';


class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) =>
          CategoryBloc(CategoryRepository())..add(LoadingCategoryevent('')),
      child: CategoryList(),
    );
  }
}
