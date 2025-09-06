import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/widgets/splash_screen.dart';
import 'package:roobai/screens/category/view/category.dart';
import 'package:roobai/screens/category/view/mobile/category.dart';
import 'package:roobai/screens/homepage/view/homepage_view.dart';
import 'package:roobai/screens/joinus/view/mobile/joinus_mobile_view.dart';
import 'package:roobai/screens/product%20view/view/mobil/products_mobile_view.dart';
import 'package:roobai/screens/product%20view/view/products_viewpage.dart';

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
          return HomepageView();
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
      //   name: RouteName.best,
      //   path: RouteName.best,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return BestProductpage();
      //   },
      // ),
      // GoRoute(
      //   name: RouteName.search,
      //   path: RouteName.search,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return SearchView();
      //   },
      // ),
    GoRoute(
  name: RouteName.product,
  path: '/product',
  builder: (context, state) {
    print('Route builder called with extra: ${state.extra}');
    print('Extra type: ${state.extra.runtimeType}');
    
    List<ProductModel> products = <ProductModel>[];
    
    if (state.extra != null) {
      try {
        // Check if it's already the right type
        if (state.extra is List<ProductModel>) {
          products = state.extra as List<ProductModel>;
        }
        // Check if it's a generic List that can be cast
        else if (state.extra is List) {
          final List genericList = state.extra as List;
          print('Generic list length: ${genericList.length}');
          
          if (genericList.isNotEmpty) {
            print('First item type: ${genericList.first.runtimeType}');
            
            // Try to filter ProductModel items
            products = genericList.whereType<ProductModel>().toList();
            
            // If that didn't work, try manual casting
            if (products.isEmpty) {
              try {
                products = genericList.cast<ProductModel>();
              } catch (castError) {
                print('Cast error: $castError');
              }
            }
          }
        }
        // Handle other types
        else {
          print('Unexpected extra type: ${state.extra.runtimeType}');
        }
      } catch (e, stackTrace) {
        print('Error processing route extra: $e');
        print('Stack trace: $stackTrace');
      }
    }
    
    print('Final products count: ${products.length}');
    return ProductmobileView(products: products);
  },
),
      GoRoute(
        name: RouteName.category,
        path: RouteName.category,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> initialValue =
              (state.extra as CategoryModel).toJson();
          Logger().d('initalvalue::route:category:$initialValue');
          return CategoryPage(initalvalue: initialValue);
        },
      ),

      // GoRoute(
      //   name: RouteName.productdetail,
      //   path: RouteName.productdetail,
      //   builder: (BuildContext context, GoRouterState state) {
      //     final Map<String, dynamic> extraData =
      //         state.extra as Map<String, dynamic>;
      //     Logger().d('route::productdetail::$extraData');
      //     return ProductDeatil(initialvalue: extraData);
      //   },
      // ),
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
