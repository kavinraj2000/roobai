import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';

class HomePage extends StatelessWidget {
  final List<HomeModel> homeModels;
  const HomePage({super.key, required this.homeModels});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomepageBloc(HomepageRepository())..add(LoadCategories(homeModels)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Categories')),
        body: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            if (state) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoaded) {
              return CategoryGridWidget(items: state.categories);
            } else if (state is CategoryError) {
              return Center(child: Text(state.error));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
