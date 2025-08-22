import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/features/product/shared/widget/splash_screen.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product/view/products.dart';
import 'package:roobai/screens/joinus/view/mobile/joinus_mobile_view.dart';
import 'package:roobai/screens/homepage/view/mobile/home.dart';
import 'package:roobai/screens/product_detail/view/mobile/product_detail_screen.dart';
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
          return Homepage();
        },
      ),
      GoRoute(
        name: RouteName.joinUs,
        path: RouteName.joinUs,
        builder: (BuildContext context, GoRouterState state) {
          return JoinUsScreen();
        },
      ),
      // GoRoute(
      //   name: RouteName.category,
      //   path: RouteName.category,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return Category();
      //   },
      // ),
      GoRoute(
        name: RouteName.search,
        path: RouteName.search,
        builder: (BuildContext context, GoRouterState state) {
          return SearchView();
        },
      ),
      GoRoute(
        name: RouteName.product,
        path: RouteName.product,
        builder: (BuildContext context, GoRouterState state) {
          return Productpage();
        },
      ),
        GoRoute(
        name: RouteName.productdetail,
        path: RouteName.productdetail,
        builder: (BuildContext context, GoRouterState state) {
          return ProductDetailScreen( );
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
