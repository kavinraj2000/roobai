import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';
import 'package:roobai/screens/mobilview/bloc/mobilview_bloc.dart';
import 'package:roobai/screens/mobilview/view/mobile/mobile_view_page.dart';


class Mobilpage extends StatelessWidget {
  const Mobilpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MobilviewBloc>(
      create: (context) =>
          MobilviewBloc(HomepageRepository())..add(Loadingmobilevent()),
      child: Mobileviewpage(),
    );
  }
}
