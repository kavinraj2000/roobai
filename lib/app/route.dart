import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/features/product/shared/widget/splash_screen.dart';
import 'package:roobai/screens/category/view/category.dart';
import 'package:roobai/screens/deal_finder/dealfinder/view/delfinder.dart';
import 'package:roobai/screens/joinus/view/mobile/joinus_mobile_view.dart';
import 'package:roobai/screens/mainscreen/homepage/home.dart';
import 'package:roobai/screens/search/view/search_view.dart';
import 'package:roobai/screens/setting/setting.dart';

class Routes {
  final log = Logger();

  GoRouter router = GoRouter(
    initialLocation: RouteName.splashScreen,
    routes: [
      GoRoute(
        name: RouteName.splashScreen,
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        name: RouteName.mainScreen,
        path: RouteName.mainScreen,
        builder: (BuildContext context, GoRouterState state) {
          return HomePage();
        },
      ),
      GoRoute(
        name: RouteName.joinUs,
        path: RouteName.joinUs,
        builder: (BuildContext context, GoRouterState state) {
          return JoinUsScreen();
        },
      ),
      GoRoute(
        name: RouteName.category,
        path: RouteName.category,
        builder: (BuildContext context, GoRouterState state) {
          return Category();
        },
      ),
      GoRoute(
        name: RouteName.search,
        path: RouteName.search,
        builder: (BuildContext context, GoRouterState state) {
          return SearchView();
        },
      ),
      GoRoute(
        name: RouteName.dealfinder,
        path: RouteName.dealfinder,
        builder: (BuildContext context, GoRouterState state) {
          return Dealfinder();
        },
      ),
      GoRoute(
        name: RouteName.setting,
        path: RouteName.setting,
        builder: (BuildContext context, GoRouterState state) {
          return Setting();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      return null;

      //   final log = Logger();
      //   final bool signedIn = context.read<LoginBloc>().state.status == LoginStatus.loggedIn;
      //   log.d("Routes:::Redirect:Is LoggedIn: $signedIn");
      //   final bool signingIn = state.matchedLocation == '/login';
      //   log.d("Routes:::Redirect:MatchedLocation: ${state.matchedLocation}");
      //   if (state.matchedLocation == '/' && !signedIn) {
      //     return null;
      //   }
      //   if (!signedIn && !signingIn) {
      //     return '/login';
      //   } else if (signedIn && signingIn) {
      //     return '/base';
      //   }
      //   return null;
      // },
      // debugLogDiagnostics: true,
      // errorBuilder: (context, state) {
      //   return FileNotFound(message: "${state.error?.message}");
    },
    // changes on the listenable will cause the router to refresh it's route
    // refreshListenable: GoRouterRefreshStream(_loginBloc.stream),
  );
}
