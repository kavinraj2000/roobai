part of 'products_bloc.dart';

abstract class ProductEvent {}

class FetchDealFinderData extends ProductEvent {
    final int page;
FetchDealFinderData(this.page);
}

class Addlikestatusevent extends ProductEvent {
  final Product product;

  Addlikestatusevent(this.product);
}
