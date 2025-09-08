part of 'protuct_view_bloc.dart';

abstract class ProductviewEvent extends Equatable {
  const ProductviewEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductViewData extends ProductviewEvent {
  const LoadProductViewData();
}



class NavigatetoProducturl extends ProductviewEvent {
  final String? productUrl;

  const NavigatetoProducturl(this.productUrl);

  @override
  List<Object?> get props => [productUrl];
}

class LoadMoreJustScroll extends ProductviewEvent {}

class RefreshProducts extends ProductviewEvent {
  final List<ProductModel> products;

  const RefreshProducts(this.products);

  @override
  List<Object> get props => [products];
}

class FilterProductsByCategory extends ProductviewEvent {
  final String pid;

  const FilterProductsByCategory(this.pid);

  @override
  List<Object?> get props => [pid];
}
