import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';
import 'package:roobai/screens/homepage/view/mobile/homeview.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomepageBloc>(
      create: (context) =>
          HomepageBloc(HomepageRepository())..add(LoadHomepageData()),
      child: const HomeView(), 
    );
  }
}
