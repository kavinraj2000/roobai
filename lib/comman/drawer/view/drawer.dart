import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/comman/drawer/bloc/drawe_bloc.dart';
import 'package:roobai/comman/drawer/repo/drawer_repo.dart';
import 'package:roobai/comman/drawer/view/drawer_cat.dart';


class Drawerwidget extends StatelessWidget {
  const Drawerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DraweBloc>(
      create: (context) =>
          DraweBloc(DrawerRepository())..add(Loadincategoryevent()),
      child: const CustomDrawerWidget(), 
    );
  }
}
