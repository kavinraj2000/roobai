part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  
  SearchQueryChanged(this.query);
  
  @override
  String toString() => 'SearchQueryChanged(query: $query)';
}

class LoadAllProducts extends SearchEvent {}

class ToggleShowSelectedOnly extends SearchEvent {}

class SelectProduct extends SearchEvent {
  final Product product;
  
  SelectProduct(this.product);
  
  @override
  String toString() => 'SelectProduct(product: ${product.productName})';
}