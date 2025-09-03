part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomepageData extends HomepageEvent {}

class LoadCategories extends HomepageEvent {
  final List<HomeModel> homeModels;
  const LoadCategories(this.homeModels);

  @override
  List<Object?> get props => [homeModels];
}

class NavigateToProductEvent extends HomepageEvent {
  final String? productUrl;
  const NavigateToProductEvent(this.productUrl);

  @override
  List<Object?> get props => [productUrl];
}


