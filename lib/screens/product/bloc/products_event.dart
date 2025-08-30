part of 'products_bloc.dart';

abstract class ProductEvent {}

class FetchDealFinderData extends ProductEvent {
FetchDealFinderData();
}

class Addlikestatusevent extends ProductEvent {
  final Product product;

  Addlikestatusevent(this.product);
}
class RefreshProducts extends ProductEvent {
   RefreshProducts();
}