import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:roobai/app/route.dart';
import 'package:roobai/comman/theme/theme.dart';
import 'package:roobai/comman/repos/storage_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => Apidatabase(), 
      child: MaterialApp.router(
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 375, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: Routes().router,
        theme: theme(),
      ),
    );
  }
}
