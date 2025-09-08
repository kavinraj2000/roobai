part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomepageData extends HomepageEvent {
  const LoadHomepageData();
}

class LoadCategories extends HomepageEvent {
  final List<HomeModel> homeModels;

  const LoadCategories(this.homeModels);

  @override
  List<Object> get props => [homeModels];
}

class NavigateToProductEvent extends HomepageEvent {
  final String? productUrl;

  const NavigateToProductEvent(this.productUrl);

  @override
  List<Object?> get props => [productUrl];
}

class LoadMoreJustScroll extends HomepageEvent {}

class Refershproducts extends HomepageEvent {
  final List<ProductModel> products;

  const Refershproducts(this.products);

  @override
  List<Object> get props => [products];
}

class NavigateToMobileProducts extends HomepageEvent {}

class NavigateToJustScrollProducts extends HomepageEvent {}