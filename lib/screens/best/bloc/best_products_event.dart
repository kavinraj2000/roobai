part of 'best_products_bloc.dart';

abstract class BestProductEvent {}

class FetchproductrData extends BestProductEvent {
  final bool isInitialLoad;
FetchproductrData({this.isInitialLoad = false});
}

class Addlikestatusevent extends BestProductEvent {
  final Product product;

  Addlikestatusevent(this.product);
}
