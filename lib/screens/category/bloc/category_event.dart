part of 'category_bloc.dart';

abstract class CategoryEvent {}

class Initialvalueevent extends CategoryEvent {
  final Map<String, dynamic>? intialvalue;
  Initialvalueevent(this.intialvalue);
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

class RefreshProductsEvent extends CategoryEvent {
  final Map<String, dynamic> cid;
  RefreshProductsEvent(this.cid);
}

class LoadMoreProductsEvent extends CategoryEvent {}

class FilterProductsEvent extends CategoryEvent {
  final Map<String, dynamic> filters;
  FilterProductsEvent(this.filters);
}
