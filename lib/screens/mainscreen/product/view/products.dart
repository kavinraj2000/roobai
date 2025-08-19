import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/mainscreen/product/bloc/products_bloc.dart';
import 'package:roobai/screens/mainscreen/product/repo/products_repository.dart';
import 'package:roobai/screens/mainscreen/product/view/products_view.dart';



class Productpage extends StatelessWidget{
  const Productpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(create: (context)=>ProductBloc(DealRepository())..add(FetchDealFinderData()),child: DealFinderView(),);
  }

}