import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/features/data/model/product_model.dart';
import 'package:roobai/screens/deal_finder/body.dart';
import 'package:roobai/screens/product/view/products.dart';


class ListDetail extends StatelessWidget {

  ProductModel productModel = ProductModel();
  String come_for = "";
  bool shouldPop = true;


  ListDetail({Key? key, required this.productModel, required this.come_for}) : super(key: key);

  //ListDetail({required this.come_for});

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: lay_bg,
          appBar: AppBar(
            backgroundColor: primaryColor,
            titleSpacing: 0,
            title: const Text(
              'Product Detail',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (come_for.isNotEmpty) {
                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainScreen1()), (Route<dynamic> route) => false);
                    context.pushReplacementNamed(RouteName.mainScreen);
                  } else {
                    Navigator.of(context).pop();
                  }
                }),
          ),
          body: SafeArea(child: Productpage()),
        ),
        onWillPop: () async {
          if (come_for.isNotEmpty) {
                    context.pushReplacementNamed(RouteName.mainScreen);
            shouldPop = !shouldPop;
          }
          return shouldPop;
        });
  }
}
