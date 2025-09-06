part of 'category_bloc.dart';

abstract class CategoryEvent {}

class Initialvalueevent extends CategoryEvent {
  Initialvalueevent();
}

class LoadProductsEvent extends CategoryEvent {
  final int? categoryId;
  final String? searchQuery;
  final Map<String, dynamic>? filters;

  LoadProductsEvent({
    this.categoryId,
    this.searchQuery,
    this.filters,
  });
}

class RefreshProductsEvent extends CategoryEvent {}

class LoadMoreProductsEvent extends CategoryEvent {}

class FilterProductsEvent extends CategoryEvent {
  final Map<String, dynamic> filters;
  
  FilterProductsEvent(this.filters);
}
