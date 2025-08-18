import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/deal_finder/dealfinder/bloc/dealfinder_bloc.dart';
import 'package:roobai/screens/deal_finder/dealfinder/repo/dealfinder_repository.dart';
import 'package:roobai/screens/deal_finder/dealfinder/view/dealdinderview.dart';


class Dealfinder extends StatelessWidget{
  const Dealfinder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DealFinderBloc>(create: (context)=>DealFinderBloc(DealRepository())..add(FetchDealFinderData(dealType: '',navigateOnLoad: false)),child: DealFinderView(),);
  }

}