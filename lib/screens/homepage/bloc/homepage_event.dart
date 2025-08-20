part of 'homepage_bloc.dart';

abstract class HomepageEvent {}

class LoadHomepageDataEvent extends HomepageEvent {}

class RefreshHomepageDataEvent extends HomepageEvent {}

class CategorySelectedEvent extends HomepageEvent {
  final String categorySlug;
  
  CategorySelectedEvent(this.categorySlug);
}

class ProductSelectedEvent extends HomepageEvent {
  final String productId;
  
  ProductSelectedEvent(this.productId);
}